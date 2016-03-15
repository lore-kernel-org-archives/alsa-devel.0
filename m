From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix unconditional GPIO toggle via
	automute
Date: Tue, 15 Mar 2016 16:49:40 +0100
Message-ID: <1458056980-8792-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 612C02655A6
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 16:49:42 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 984F9AB9D
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 15:49:41 +0000 (UTC)
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

Cirrus HD-audio driver may adjust GPIO pins for EAPD dynamically
depending on the jack plug state.  This works fine for the auto-mute
mode where the speaker gets muted upon the HP jack plug.   OTOH, when
the auto-mute mode is off, this turns off the EAPD unexpectedly
depending on the jack state, which results in the silent speaker
output.

This patch fixes the silent speaker output issue by setting GPIO bits
constantly when the auto-mute mode is off.

Reported-and-tested-by: moosotc@gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index c1c855a6c0af..a47e8ae0eb30 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -174,8 +174,12 @@ static void cs_automute(struct hda_codec *codec)
 	snd_hda_gen_update_outputs(codec);
 
 	if (spec->gpio_eapd_hp || spec->gpio_eapd_speaker) {
-		spec->gpio_data = spec->gen.hp_jack_present ?
-			spec->gpio_eapd_hp : spec->gpio_eapd_speaker;
+		if (spec->gen.automute_speaker)
+			spec->gpio_data = spec->gen.hp_jack_present ?
+				spec->gpio_eapd_hp : spec->gpio_eapd_speaker;
+		else
+			spec->gpio_data =
+				spec->gpio_eapd_hp | spec->gpio_eapd_speaker;
 		snd_hda_codec_write(codec, 0x01, 0,
 				    AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 	}
-- 
2.7.3
