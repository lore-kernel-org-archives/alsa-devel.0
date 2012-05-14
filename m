From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/15] ALSA: hda - More robustify the
	power-up/down sequence
Date: Mon, 14 May 2012 17:32:00 +0200
Message-ID: <1337009526-26256-10-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 96FBB24A2B
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0E07191240
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Check the power_transition up/down state instead of boolean bit, so
that the power-up sequence can cancel the pending power-down work
properly.  Also, by moving cancel_delayed_work_sync() before the
actual power-up sequence, make sure that the delayed power-down is
completed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |   22 +++++++++++++++-------
 sound/pci/hda/hda_codec.h |    2 +-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e0f8667..731f850 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2265,7 +2265,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	/* OK, let it free */
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-	cancel_delayed_work(&codec->power_work);
+	cancel_delayed_work_sync(&codec->power_work);
 	codec->power_on = 0;
 	codec->power_transition = 0;
 	codec->power_jiffies = jiffies;
@@ -3491,11 +3491,14 @@ static void hda_call_codec_suspend(struct hda_codec *codec)
 			    codec->afg ? codec->afg : codec->mfg,
 			    AC_PWRST_D3);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-	snd_hda_update_power_acct(codec);
 	cancel_delayed_work(&codec->power_work);
+	spin_lock(&codec->power_lock);
+	snd_hda_update_power_acct(codec);
+	trace_hda_power_down(codec);
 	codec->power_on = 0;
 	codec->power_transition = 0;
 	codec->power_jiffies = jiffies;
+	spin_unlock(&codec->power_lock);
 #endif
 }
 
@@ -4294,13 +4297,15 @@ static void hda_power_work(struct work_struct *work)
 	struct hda_bus *bus = codec->bus;
 
 	spin_lock(&codec->power_lock);
+	if (codec->power_transition > 0) { /* during power-up sequence? */
+		spin_unlock(&codec->power_lock);
+		return;
+	}
 	if (!codec->power_on || codec->power_count) {
 		codec->power_transition = 0;
 		spin_unlock(&codec->power_lock);
 		return;
 	}
-
-	trace_hda_power_down(codec);
 	spin_unlock(&codec->power_lock);
 
 	hda_call_codec_suspend(codec);
@@ -4341,11 +4346,15 @@ void snd_hda_power_up(struct hda_codec *codec)
 
 	spin_lock(&codec->power_lock);
 	codec->power_count++;
-	if (codec->power_on || codec->power_transition) {
+	if (codec->power_on || codec->power_transition > 0) {
 		spin_unlock(&codec->power_lock);
 		return;
 	}
+	spin_unlock(&codec->power_lock);
 
+	cancel_delayed_work_sync(&codec->power_work);
+
+	spin_lock(&codec->power_lock);
 	trace_hda_power_up(codec);
 	snd_hda_update_power_acct(codec);
 	codec->power_on = 1;
@@ -4358,7 +4367,6 @@ void snd_hda_power_up(struct hda_codec *codec)
 	hda_call_codec_resume(codec);
 
 	spin_lock(&codec->power_lock);
-	cancel_delayed_work(&codec->power_work);
 	codec->power_transition = 0;
 	spin_unlock(&codec->power_lock);
 }
@@ -4383,7 +4391,7 @@ void snd_hda_power_down(struct hda_codec *codec)
 		return;
 	}
 	if (power_save(codec)) {
-		codec->power_transition = 1; /* avoid reentrance */
+		codec->power_transition = -1; /* avoid reentrance */
 		queue_delayed_work(codec->bus->workq, &codec->power_work,
 				msecs_to_jiffies(power_save(codec) * 1000));
 	}
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 78f8914..fce30b4 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -859,7 +859,7 @@ struct hda_codec {
 	unsigned int no_jack_detect:1;	/* Machine has no jack-detection */
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	unsigned int power_on :1;	/* current (global) power-state */
-	unsigned int power_transition :1; /* power-state in transition */
+	int power_transition;	/* power-state in transition */
 	int power_count;	/* current (global) power refcount */
 	struct delayed_work power_work; /* delayed task for powerdown */
 	unsigned long power_on_acct;
-- 
1.7.9.2
