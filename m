From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: ak411x: Fix stall in work callback
Date: Fri, 16 Jan 2015 18:16:40 +0100
Message-ID: <1421428603-6739-2-git-send-email-tiwai@suse.de>
References: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F08A326041B
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:16:46 +0100 (CET)
In-Reply-To: <1421428603-6739-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

When ak4114 work calls its callback and the callback invokes
ak4114_reinit(), it stalls due to flush_delayed_work().  For avoiding
this, control the reentrance by introducing a refcount.  Also
flush_delayed_work() is replaced with cancel_delayed_work_sync().

The exactly same bug is present in ak4113.c and fixed as well.

Reported-by: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ak4113.h   |  2 +-
 include/sound/ak4114.h   |  2 +-
 sound/i2c/other/ak4113.c | 17 ++++++++---------
 sound/i2c/other/ak4114.c | 18 ++++++++----------
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/sound/ak4113.h b/include/sound/ak4113.h
index 2609048c1d44..3a34f6edc2d1 100644
--- a/include/sound/ak4113.h
+++ b/include/sound/ak4113.h
@@ -286,7 +286,7 @@ struct ak4113 {
 	ak4113_write_t *write;
 	ak4113_read_t *read;
 	void *private_data;
-	unsigned int init:1;
+	atomic_t wq_processing;
 	spinlock_t lock;
 	unsigned char regmap[AK4113_WRITABLE_REGS];
 	struct snd_kcontrol *kctls[AK4113_CONTROLS];
diff --git a/include/sound/ak4114.h b/include/sound/ak4114.h
index 52f02a60dba7..069299a88915 100644
--- a/include/sound/ak4114.h
+++ b/include/sound/ak4114.h
@@ -168,7 +168,7 @@ struct ak4114 {
 	ak4114_write_t * write;
 	ak4114_read_t * read;
 	void * private_data;
-	unsigned int init: 1;
+	atomic_t wq_processing;
 	spinlock_t lock;
 	unsigned char regmap[6];
 	unsigned char txcsb[5];
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 1a3a6fa27158..c6bba99a90b2 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -56,8 +56,7 @@ static inline unsigned char reg_read(struct ak4113 *ak4113, unsigned char reg)
 
 static void snd_ak4113_free(struct ak4113 *chip)
 {
-	chip->init = 1;	/* don't schedule new work */
-	mb();
+	atomic_inc(&chip->wq_processing);	/* don't schedule new work */
 	cancel_delayed_work_sync(&chip->work);
 	kfree(chip);
 }
@@ -89,6 +88,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 	chip->write = write;
 	chip->private_data = private_data;
 	INIT_DELAYED_WORK(&chip->work, ak4113_stats);
+	atomic_set(&chip->wq_processing, 0);
 
 	for (reg = 0; reg < AK4113_WRITABLE_REGS ; reg++)
 		chip->regmap[reg] = pgm[reg];
@@ -139,13 +139,11 @@ static void ak4113_init_regs(struct ak4113 *chip)
 
 void snd_ak4113_reinit(struct ak4113 *chip)
 {
-	chip->init = 1;
-	mb();
-	flush_delayed_work(&chip->work);
+	if (atomic_inc_return(&chip->wq_processing) == 1)
+		cancel_delayed_work_sync(&chip->work);
 	ak4113_init_regs(chip);
 	/* bring up statistics / event queing */
-	chip->init = 0;
-	if (chip->kctls[0])
+	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
 EXPORT_SYMBOL_GPL(snd_ak4113_reinit);
@@ -632,8 +630,9 @@ static void ak4113_stats(struct work_struct *work)
 {
 	struct ak4113 *chip = container_of(work, struct ak4113, work.work);
 
-	if (!chip->init)
+	if (atomic_inc_return(&chip->wq_processing) == 1)
 		snd_ak4113_check_rate_and_errors(chip, chip->check_flags);
 
-	schedule_delayed_work(&chip->work, HZ / 10);
+	if (atomic_dec_and_test(&chip->wq_processing))
+		schedule_delayed_work(&chip->work, HZ / 10);
 }
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index c7f56339415d..b70e6eccbd03 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -66,8 +66,7 @@ static void reg_dump(struct ak4114 *ak4114)
 
 static void snd_ak4114_free(struct ak4114 *chip)
 {
-	chip->init = 1;	/* don't schedule new work */
-	mb();
+	atomic_inc(&chip->wq_processing);	/* don't schedule new work */
 	cancel_delayed_work_sync(&chip->work);
 	kfree(chip);
 }
@@ -100,6 +99,7 @@ int snd_ak4114_create(struct snd_card *card,
 	chip->write = write;
 	chip->private_data = private_data;
 	INIT_DELAYED_WORK(&chip->work, ak4114_stats);
+	atomic_set(&chip->wq_processing, 0);
 
 	for (reg = 0; reg < 6; reg++)
 		chip->regmap[reg] = pgm[reg];
@@ -152,13 +152,11 @@ static void ak4114_init_regs(struct ak4114 *chip)
 
 void snd_ak4114_reinit(struct ak4114 *chip)
 {
-	chip->init = 1;
-	mb();
-	flush_delayed_work(&chip->work);
+	if (atomic_inc_return(&chip->wq_processing) == 1)
+		cancel_delayed_work_sync(&chip->work);
 	ak4114_init_regs(chip);
 	/* bring up statistics / event queing */
-	chip->init = 0;
-	if (chip->kctls[0])
+	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
 
@@ -612,10 +610,10 @@ static void ak4114_stats(struct work_struct *work)
 {
 	struct ak4114 *chip = container_of(work, struct ak4114, work.work);
 
-	if (!chip->init)
+	if (atomic_inc_return(&chip->wq_processing) == 1)
 		snd_ak4114_check_rate_and_errors(chip, chip->check_flags);
-
-	schedule_delayed_work(&chip->work, HZ / 10);
+	if (atomic_dec_and_test(&chip->wq_processing))
+		schedule_delayed_work(&chip->work, HZ / 10);
 }
 
 EXPORT_SYMBOL(snd_ak4114_create);
-- 
2.2.1
