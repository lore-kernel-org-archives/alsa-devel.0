From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Thu, 23 Apr 2015 21:12:50 +0200
Message-ID: <1799826.AYplPzq8AK@xps13>
References: <23057263.IjMh4t6SYF@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 324A72602AD
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 21:12:53 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so19397288wic.1
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 12:12:52 -0700 (PDT)
In-Reply-To: <23057263.IjMh4t6SYF@xps13>
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sunday 19 April 2015 19:26:58 Gabriele Mazzotta wrote:
> Hi,
> 
> I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
> command verb caches, too") is somehow causing a pop noise on startup
> when headphones are plugged in, but I couldn't figure out the exact
> cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> Realtek ALC3661)? Does anyone have any idea of what the cause might be?

Hi,

I don't know why a551d91473 caused the issue, but I found the real
cause of problem.

On init, create_input_ctls() sets the vref of nid 0x19 to 80 (as
returned by snd_hda_get_default_vref()), but it should be set to HIZ.
This is not so different from the issue addressed by f38663ab5c
("ALSA: hda - Set internal mic as default input source on Dell XPS 13 9333").

I made a patch to prevent this from happening.

Setting the vref is not necessary since alc_update_headset_mode() will
take care of it.

Should I maybe add a new flag instead of using suppress_hp_mic_detect?

---
 sound/pci/hda/hda_generic.c   | 3 ++-
 sound/pci/hda/patch_realtek.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3d2597b..adf84ab 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3257,7 +3257,8 @@ static int create_input_ctls(struct hda_codec *codec)
 			continue;
 
 		val = PIN_IN;
-		if (cfg->inputs[i].type == AUTO_PIN_MIC)
+		if (cfg->inputs[i].type == AUTO_PIN_MIC &&
+		    !spec->suppress_hp_mic_detect)
 			val |= snd_hda_get_default_vref(codec, pin);
 		if (pin != spec->hp_mic_pin)
 			set_pin_target(codec, pin, val, false);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 231d0e4..3d854e7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4062,6 +4062,7 @@ static void alc_fixup_headset_mode(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gen.suppress_hp_mic_detect = 1;
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC | HDA_PINCFG_HEADPHONE_MIC;
 		break;
 	case HDA_FIXUP_ACT_PROBE:
