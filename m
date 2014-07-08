From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - add capture mute led support
	in led_power_filter
Date: Tue,  8 Jul 2014 17:56:15 +0800
Message-ID: <1404813375-7602-2-git-send-email-hui.wang@canonical.com>
References: <1404813375-7602-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 259A926109E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 11:56:45 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id lf10so7090554pab.16
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 02:56:43 -0700 (PDT)
In-Reply-To: <1404813375-7602-1-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, kailang@realtek.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Now the led_power_filter() needs to handle 3 situations:
    - only mute_led_nid is set
    - only cap_mute_led_nid is set
    - both mute_led_ind and cap_mute_led_nid are set

BugLink: https://bugs.launchpad.net/bugs/1329580
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 73b1759..512582b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3403,7 +3403,8 @@ static unsigned int led_power_filter(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (power_state != AC_PWRST_D3 || nid != spec->mute_led_nid)
+	if (power_state != AC_PWRST_D3 || nid == 0 ||
+	    (nid != spec->mute_led_nid && nid != spec->cap_mute_led_nid))
 		return power_state;
 
 	/* Set pin ctl again, it might have just been set to 0 */
@@ -3563,6 +3564,7 @@ static void alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,
 		spec->gpio_led = 0;
 		spec->cap_mute_led_nid = 0x18;
 		snd_hda_add_verbs(codec, gpio_init);
+		codec->power_filter = led_power_filter;
 	}
 }
 
-- 
1.8.1.2
