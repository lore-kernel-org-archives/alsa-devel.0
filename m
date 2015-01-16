From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: ak411x: Fix race of reinit() calls
Date: Fri, 16 Jan 2015 18:16:43 +0100
Message-ID: <1421428603-6739-5-git-send-email-tiwai@suse.de>
References: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 04993260427
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:16:47 +0100 (CET)
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

Protect the call with a mutex, as this may be called in parallel
(either from the PCM rate change and the clock change).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ak4113.h   | 1 +
 include/sound/ak4114.h   | 1 +
 sound/i2c/other/ak4113.c | 3 +++
 sound/i2c/other/ak4114.c | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/include/sound/ak4113.h b/include/sound/ak4113.h
index f4fbf6888e78..58c145620c3c 100644
--- a/include/sound/ak4113.h
+++ b/include/sound/ak4113.h
@@ -287,6 +287,7 @@ struct ak4113 {
 	ak4113_read_t *read;
 	void *private_data;
 	atomic_t wq_processing;
+	struct mutex reinit_mutex;
 	spinlock_t lock;
 	unsigned char regmap[AK4113_WRITABLE_REGS];
 	struct snd_kcontrol *kctls[AK4113_CONTROLS];
diff --git a/include/sound/ak4114.h b/include/sound/ak4114.h
index e681df2c95e1..b6feb7e225f2 100644
--- a/include/sound/ak4114.h
+++ b/include/sound/ak4114.h
@@ -169,6 +169,7 @@ struct ak4114 {
 	ak4114_read_t * read;
 	void * private_data;
 	atomic_t wq_processing;
+	struct mutex reinit_mutex;
 	spinlock_t lock;
 	unsigned char regmap[6];
 	unsigned char txcsb[5];
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index c2b14d981fa1..88844881cbff 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -89,6 +89,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 	chip->private_data = private_data;
 	INIT_DELAYED_WORK(&chip->work, ak4113_stats);
 	atomic_set(&chip->wq_processing, 0);
+	mutex_init(&chip->reinit_mutex);
 
 	for (reg = 0; reg < AK4113_WRITABLE_REGS ; reg++)
 		chip->regmap[reg] = pgm[reg];
@@ -141,7 +142,9 @@ void snd_ak4113_reinit(struct ak4113 *chip)
 {
 	if (atomic_inc_return(&chip->wq_processing) == 1)
 		cancel_delayed_work_sync(&chip->work);
+	mutex_lock(&chip->reinit_mutex);
 	ak4113_init_regs(chip);
+	mutex_unlock(&chip->reinit_mutex);
 	/* bring up statistics / event queing */
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index ee639f57b664..5a4cf3fab4ae 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -100,6 +100,7 @@ int snd_ak4114_create(struct snd_card *card,
 	chip->private_data = private_data;
 	INIT_DELAYED_WORK(&chip->work, ak4114_stats);
 	atomic_set(&chip->wq_processing, 0);
+	mutex_init(&chip->reinit_mutex);
 
 	for (reg = 0; reg < 6; reg++)
 		chip->regmap[reg] = pgm[reg];
@@ -156,7 +157,9 @@ void snd_ak4114_reinit(struct ak4114 *chip)
 {
 	if (atomic_inc_return(&chip->wq_processing) == 1)
 		cancel_delayed_work_sync(&chip->work);
+	mutex_lock(&chip->reinit_mutex);
 	ak4114_init_regs(chip);
+	mutex_unlock(&chip->reinit_mutex);
 	/* bring up statistics / event queing */
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
-- 
2.2.1
