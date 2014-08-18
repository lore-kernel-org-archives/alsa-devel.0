From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - restore the gpio led after resume
Date: Mon, 18 Aug 2014 15:25:19 +0800
Message-ID: <1408346720-3124-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EC781265460
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 09:25:36 +0200 (CEST)
Received: by mail-pa0-f51.google.com with SMTP id ey11so7085564pad.24
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 00:25:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, franz.hsieh@canonical.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On some HP laptops, the mute led is controlled by codec gpio.

When some machine resume from s3/s4, the codec gpio data will be
cleared to 0 by BIOS:
Before suspend:
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
After resume:
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0

To skip the AFG node to enter S3 can't fix this problem.

A workaround is to restore the gpio data when the system resume
back from s3/s4. It is safe even on the machines without this
problem.

BugLink: https://bugs.launchpad.net/bugs/1358116
Tested-by: Franz Hsieh <franz.hsieh@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b32ce08..9c49bf5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3432,6 +3432,12 @@ static unsigned int led_power_filter(struct hda_codec *codec,
 	    (nid != spec->mute_led_nid && nid != spec->cap_mute_led_nid))
 		return power_state;
 
+	if (nid == codec->afg && power_state == AC_PWRST_D0 && spec->gpio_led) {
+		snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DATA,
+			    spec->gpio_led);
+		return power_state;
+	}
+
 	/* Set pin ctl again, it might have just been set to 0 */
 	snd_hda_set_pin_ctl(codec, nid,
 			    snd_hda_codec_get_pin_target(codec, nid));
-- 
1.9.1
