From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] Add 92HD81B1C device id
Date: Wed, 01 Apr 2009 14:49:48 -0400
Message-ID: <49D3B74C.9070409@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 5762C103814
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 20:50:00 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, "Hutson, Whit" <Whit.Hutson@idt.com>
List-Id: alsa-devel@alsa-project.org

Added device id in struct for codec 92HD81B1C (0x111d76d5).

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index b5e108a..b34d78b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4895,6 +4895,7 @@ again:
 	switch (codec->vendor_id) {
 	case 0x111d7604:
 	case 0x111d7605:
+	case 0x111d76d5:
 		if (spec->board_config == STAC_92HD83XXX_PWR_REF)
 			break;
 		spec->num_pwrs = 0;
@@ -5707,6 +5708,7 @@ static struct hda_codec_preset snd_hda_preset_sigmatel[] = {
 	{ .id = 0x111d7603, .name = "92HD75B3X5", .patch = patch_stac92hd71bxx},
 	{ .id = 0x111d7604, .name = "92HD83C1X5", .patch = patch_stac92hd83xxx},
 	{ .id = 0x111d7605, .name = "92HD81B1X5", .patch = patch_stac92hd83xxx},
+	{ .id = 0x111d76d5, .name = "92HD81B1C5", .patch = patch_stac92hd83xxx},
 	{ .id = 0x111d7608, .name = "92HD75B2X5", .patch = patch_stac92hd71bxx},
 	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
-- 
1.5.6.3
