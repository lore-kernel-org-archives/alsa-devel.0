From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/11] ALSA: i2c: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:32 +0100
Message-ID: <20190204152036.14102-8-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DF48726755E
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 768F3ADBE
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:40 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Simplify the proc fs creation code with new helper functions,
snd_card_ro_proc_new() and snd_card_rw_proc_new().
Just a code refactoring and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4113.c      | 5 ++---
 sound/i2c/other/ak4114.c      | 5 ++---
 sound/i2c/other/ak4xxx-adda.c | 8 +-------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 4099e6062d3c..573599d0378d 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -492,9 +492,8 @@ static void snd_ak4113_proc_regs_read(struct snd_info_entry *entry,
 
 static void snd_ak4113_proc_init(struct ak4113 *ak4113)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ak4113->card, "ak4113", &entry))
-		snd_info_set_text_ops(entry, ak4113, snd_ak4113_proc_regs_read);
+	snd_card_ro_proc_new(ak4113->card, "ak4113", ak4113,
+			     snd_ak4113_proc_regs_read);
 }
 
 int snd_ak4113_build(struct ak4113 *ak4113,
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index 7fb1aeb46915..76afb975782d 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -465,9 +465,8 @@ static void snd_ak4114_proc_regs_read(struct snd_info_entry *entry,
 
 static void snd_ak4114_proc_init(struct ak4114 *ak4114)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ak4114->card, "ak4114", &entry))
-		snd_info_set_text_ops(entry, ak4114, snd_ak4114_proc_regs_read);
+	snd_card_ro_proc_new(ak4114->card, "ak4114", ak4114,
+			     snd_ak4114_proc_regs_read);
 }
 
 int snd_ak4114_build(struct ak4114 *ak4114,
diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 7f2761a2e7c8..62a6c5fa96b5 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -875,13 +875,7 @@ static void proc_regs_read(struct snd_info_entry *entry,
 
 static int proc_init(struct snd_akm4xxx *ak)
 {
-	struct snd_info_entry *entry;
-	int err;
-	err = snd_card_proc_new(ak->card, ak->name, &entry);
-	if (err < 0)
-		return err;
-	snd_info_set_text_ops(entry, ak, proc_regs_read);
-	return 0;
+	return snd_card_ro_proc_new(ak->card, ak->name, ak, proc_regs_read);
 }
 
 int snd_akm4xxx_build_controls(struct snd_akm4xxx *ak)
-- 
2.16.4
