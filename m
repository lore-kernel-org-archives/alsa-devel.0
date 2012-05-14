From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/15] ALSA: hda - Always resume the codec
	immediately
Date: Mon, 14 May 2012 17:31:54 +0200
Message-ID: <1337009526-26256-4-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 757B724A26
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E62218FD0F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
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

This is a fix for the problem in commit 785f857d1c, the pop noise
issue on some machines with ALC269.  The problem was the uninitialized
state after the resume due to the delayed resume of the codec chips.
In that commit, we tried to fix by forcibly putting the codec to D3 at
suspend.  But, this still also leaves the uninitialized state after
resume, and it _might_ be still problematic with some BIOS.  Since the
commit turned out to regress another issues, we reverted it in the
end.

Now, in this fix, try to fix by turning on the codec immediately at
the resume path.  We need to take care of the power-saving in this
case.  When the device is woken up at the power-saved state, it should
go power-saving again after the resume.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |    9 +++++++--
 sound/pci/hda/hda_codec.h |    2 --
 sound/pci/hda/hda_intel.c |   14 +-------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 98976c8..e134e72 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3500,6 +3500,10 @@ static void hda_call_codec_suspend(struct hda_codec *codec)
  */
 static void hda_call_codec_resume(struct hda_codec *codec)
 {
+	/* set as if powered on for avoiding re-entering the resume
+	 * in the resume / power-save sequence
+	 */
+	hda_keep_power_on(codec);
 	hda_set_power_state(codec,
 			    codec->afg ? codec->afg : codec->mfg,
 			    AC_PWRST_D0);
@@ -3515,6 +3519,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		snd_hda_codec_resume_amp(codec);
 		snd_hda_codec_resume_cache(codec);
 	}
+	snd_hda_power_down(codec); /* flag down before returning */
 }
 #endif /* CONFIG_PM */
 
@@ -4332,6 +4337,7 @@ void snd_hda_power_up(struct hda_codec *codec)
 	snd_hda_update_power_acct(codec);
 	codec->power_on = 1;
 	codec->power_jiffies = jiffies;
+	codec->power_transition = 1; /* avoid reentrance */
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus);
 	hda_call_codec_resume(codec);
@@ -5521,8 +5527,7 @@ int snd_hda_resume(struct hda_bus *bus)
 	list_for_each_entry(codec, &bus->codec_list, list) {
 		if (codec->patch_ops.pre_resume)
 			codec->patch_ops.pre_resume(codec);
-		if (snd_hda_codec_needs_resume(codec))
-			hda_call_codec_resume(codec);
+		hda_call_codec_resume(codec);
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 56b4f74..0fe6491 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -1051,12 +1051,10 @@ const char *snd_hda_get_jack_location(u32 cfg);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 void snd_hda_power_up(struct hda_codec *codec);
 void snd_hda_power_down(struct hda_codec *codec);
-#define snd_hda_codec_needs_resume(codec) codec->power_count
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
 static inline void snd_hda_power_up(struct hda_codec *codec) {}
 static inline void snd_hda_power_down(struct hda_codec *codec) {}
-#define snd_hda_codec_needs_resume(codec) 1
 #endif
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6e958bf..c19e71a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2351,17 +2351,6 @@ static void azx_power_notify(struct hda_bus *bus)
  * power management
  */
 
-static int snd_hda_codecs_inuse(struct hda_bus *bus)
-{
-	struct hda_codec *codec;
-
-	list_for_each_entry(codec, &bus->codec_list, list) {
-		if (snd_hda_codec_needs_resume(codec))
-			return 1;
-	}
-	return 0;
-}
-
 static int azx_suspend(struct pci_dev *pci, pm_message_t state)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
@@ -2408,8 +2397,7 @@ static int azx_resume(struct pci_dev *pci)
 		return -EIO;
 	azx_init_pci(chip);
 
-	if (snd_hda_codecs_inuse(chip->bus))
-		azx_init_chip(chip, 1);
+	azx_init_chip(chip, 1);
 
 	snd_hda_resume(chip->bus);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
-- 
1.7.9.2
