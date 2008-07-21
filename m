From: Nicolas Boichat <nicolas@boichat.ch>
Subject: [PATCH] Allow to force model to intel-mac-v3 in
	snd_hda_intel (sigmatel).
Date: Mon, 21 Jul 2008 22:18:01 +0800
Message-ID: <48849A99.6070706@boichat.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 26.mail-out.ovh.net (26.mail-out.ovh.net [91.121.27.225])
	by alsa0.perex.cz (Postfix) with SMTP id CBE952434A
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 16:18:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Currently, even if you pass model=intel-mac-v3 as a module parameter to
snd_hda_intel, the function patch_stac922x (patch_sigmatel.c) will still
try to auto-detect the model type. This is a problem on my MacBook Pro 1st
generation, which needs intel-mac-v3, but sometimes incorrectly reports
0x00000100 as subsystem id, which causes the switch in patch_stac922x to
select intel-mac-v4.

To fix this, I added a new model called intel-mac-auto, so in case no
module parameter is passed, and an Intel Mac board is detected, the
model will be automatically detected, while no detection will be done
if the model is forced to intel-mac-v3.

This problem has been around for quite a while, and I used to fix it
by moving the case statement for 0x00000100 in patch_stac922x so that
intel-mac-v3 is chosen.

Another way to fix the problem would be to check if a module parameter
was set directly in patch_stac922x, using something like this:
if (spec->board_config == STAC_INTEL_MAC_V3 &&
	!codec->bus->modelname) {

But I think it is less elegant (if you prefer that way, I can prepare a
patch).

This applies against 2.6.26, and should apply without any problem on the
latest git.

Thanks,

Best regards,

Nicolas

Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
---

 Documentation/sound/alsa/ALSA-Configuration.txt |    1 +
 sound/pci/hda/patch_sigmatel.c                  |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)


diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 0bbee38..705ca75 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1017,6 +1017,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 	  intel-mac-v3	Intel Mac Type 3
 	  intel-mac-v4	Intel Mac Type 4
 	  intel-mac-v5	Intel Mac Type 5
+	  intel-mac-auto Intel Mac (detect type according to subsystem id)
 	  macmini	Intel Mac Mini (equivalent with type 3)
 	  macbook	Intel Mac Book (eq. type 5)
 	  macbook-pro-v1 Intel Mac Book Pro 1st generation (eq. type 3)
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a4f44a0..8f71b48 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -94,6 +94,9 @@ enum {
 	STAC_INTEL_MAC_V3,
 	STAC_INTEL_MAC_V4,
 	STAC_INTEL_MAC_V5,
+	STAC_INTEL_MAC_AUTO, /* This model is selected if no module parameter
+			      * is given, one of the above models will be
+			      * chosen according to the subsystem id. */
 	/* for backward compatibility */
 	STAC_MACMINI,
 	STAC_MACBOOK,
@@ -1473,6 +1476,7 @@ static unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
 	[STAC_INTEL_MAC_V3] = intel_mac_v3_pin_configs,
 	[STAC_INTEL_MAC_V4] = intel_mac_v4_pin_configs,
 	[STAC_INTEL_MAC_V5] = intel_mac_v5_pin_configs,
+	[STAC_INTEL_MAC_AUTO] = intel_mac_v3_pin_configs,
 	/* for backward compatibility */
 	[STAC_MACMINI] = intel_mac_v3_pin_configs,
 	[STAC_MACBOOK] = intel_mac_v5_pin_configs,
@@ -1495,6 +1499,7 @@ static const char *stac922x_models[STAC_922X_MODELS] = {
 	[STAC_INTEL_MAC_V3] = "intel-mac-v3",
 	[STAC_INTEL_MAC_V4] = "intel-mac-v4",
 	[STAC_INTEL_MAC_V5] = "intel-mac-v5",
+	[STAC_INTEL_MAC_AUTO] = "intel-mac-auto",
 	/* for backward compatibility */
 	[STAC_MACMINI]	= "macmini",
 	[STAC_MACBOOK]	= "macbook",
@@ -1566,9 +1571,9 @@ static struct snd_pci_quirk stac922x_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x0707,
 		      "Intel D945P", STAC_D945GTP5),
 	/* other systems  */
-	/* Apple Mac Mini (early 2006) */
+	/* Apple Intel Mac (Mac Mini, MacBook, MacBook Pro...) */
 	SND_PCI_QUIRK(0x8384, 0x7680,
-		      "Mac Mini", STAC_INTEL_MAC_V3),
+		      "Mac", STAC_INTEL_MAC_AUTO),
 	/* Dell systems  */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01a7,
 		      "unknown Dell", STAC_922X_DELL_D81),
@@ -3709,7 +3714,7 @@ static int patch_stac922x(struct hda_codec *codec)
 	spec->board_config = snd_hda_check_board_config(codec, STAC_922X_MODELS,
 							stac922x_models,
 							stac922x_cfg_tbl);
-	if (spec->board_config == STAC_INTEL_MAC_V3) {
+	if (spec->board_config == STAC_INTEL_MAC_AUTO) {
 		spec->gpio_mask = spec->gpio_dir = 0x03;
 		spec->gpio_data = 0x03;
 		/* Intel Macs have all same PCI SSID, so we need to check
@@ -3741,6 +3746,9 @@ static int patch_stac922x(struct hda_codec *codec)
 		case 0x106b2200:
 			spec->board_config = STAC_INTEL_MAC_V5;
 			break;
+		default:
+			spec->board_config = STAC_INTEL_MAC_V3;
+			break;
 		}
 	}
