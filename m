From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2] ALSA: hda - restore the gpio led after resume
Date: Tue, 19 Aug 2014 12:07:03 +0800
Message-ID: <1408421223-10913-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com, franz.hsieh@canonical.com
List-Id: alsa-devel@alsa-project.org

On some HP laptops, the mute led is controlled by codec gpio.

When some machine resume from s3/s4, the codec gpio data will be
cleared to 0 by BIOS:
Before suspend:
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
After resume:
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0

To skip the AFG node to enter D3 can't fix this problem.

A workaround is to restore the gpio data when the system resume
back from s3/s4. It is safe even on the machines without this
problem.

BugLink: https://bugs.launchpad.net/bugs/1358116
Tested-by: Franz Hsieh <franz.hsieh@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
V2: move the verb write from led_power_filter to alc269_resume

 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b32ce08..d71270a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3268,6 +3268,15 @@ static int alc269_resume(struct hda_codec *codec)
 	snd_hda_codec_resume_cache(codec);
 	alc_inv_dmic_sync(codec, true);
 	hda_call_check_power_status(codec, 0x01);
+
+	/* on some machine, the BIOS will clear the codec gpio data when enter
+	 * suspend, and won't restore the data after resume, so we restore it
+	 * in the driver.
+	 */
+	if (spec->gpio_led)
+		snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DATA,
+			    spec->gpio_led);
+
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
 
-- 
1.9.1
