From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: hda - use generic hdmi parser for ATI
	R6xx codec
Date: Sun,  5 Dec 2010 02:34:15 +0200
Message-ID: <1291509255-28207-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 269EE103859
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2010 01:34:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: John Ettedgui <john.ettedgui@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Switch to the generic hdmi parser for codec id 1002:aa01 (ATI R6xx
HDMI), as the codec appears to work fine with it.

Note that the codec is still limited to stereo output only, despite it
reportedly being multichannel capable. Some as of yet unknown quirks
will be needed to get that working.

Testing was done on 2.6.36 by John Ettedgui.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Tested-by: John Ettedgui <john.ettedgui@gmail.com>
---

As per the "ALSA Multichannel through HDMI" thread, the generic parser
seems to work for this. So here's a patch against sound master.

 sound/pci/hda/patch_hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d3e49aa..f2267cf 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1533,7 +1533,7 @@ static struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x1002793c, .name = "RS600 HDMI",	.patch = patch_atihdmi },
 { .id = 0x10027919, .name = "RS600 HDMI",	.patch = patch_atihdmi },
 { .id = 0x1002791a, .name = "RS690/780 HDMI",	.patch = patch_atihdmi },
-{ .id = 0x1002aa01, .name = "R6xx HDMI",	.patch = patch_atihdmi },
+{ .id = 0x1002aa01, .name = "R6xx HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x10951390, .name = "SiI1390 HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x10951392, .name = "SiI1392 HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x17e80047, .name = "Chrontel HDMI",	.patch = patch_generic_hdmi },
-- 
1.7.3
