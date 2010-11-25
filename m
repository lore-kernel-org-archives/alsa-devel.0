From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Fix ALC660-VD/ALC861-VD
	capture/playback mixers
Date: Thu, 25 Nov 2010 00:08:01 -0200
Message-ID: <20101125000801.3933b48b@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[187.115.55.249])
	by alsa0.perex.cz (Postfix) with ESMTP id F1E95103B0E
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 03:08:08 +0100 (CET)
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

The mixer nids passed to alc_auto_create_input_ctls are wrong: 0x15 is
a pin, and 0x09 is the ADC on both ALC660-VD/ALC861-VD. Thus with
current code, input playback volume/switches and input source mixer
controls are not created, and recording doesn't work. Select correct
mixers, 0x0b (input playback mixer) and 0x22 (capture source mixer).

Reference: https://qa.mandriva.com/show_bug.cgi?id=61159

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4b3afe..5aafae9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16952,7 +16952,7 @@ static struct alc_config_preset alc861vd_presets[] = {
 static int alc861vd_auto_create_input_ctls(struct hda_codec *codec,
 						const struct auto_pin_cfg *cfg)
 {
-	return alc_auto_create_input_ctls(codec, cfg, 0x15, 0x09, 0);
+	return alc_auto_create_input_ctls(codec, cfg, 0x0b, 0x22, 0);
 }
 
 
-- 
1.7.3.2
