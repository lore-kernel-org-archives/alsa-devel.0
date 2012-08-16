From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Don't set invalid volume knob
	command on IDT 92hd75bxx
Date: Thu, 16 Aug 2012 13:53:05 +0200
Message-ID: <1345117985-7153-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D922E265B5D
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:23:22 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Instead of blindly initializing a volume knob widget, first check
that there actually is a volume knob widget.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Relevant alsa info: 92hd75b3x5-hp-probook-6550b-ccert-201101-6954


diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 94040cc..1018324 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4272,7 +4272,8 @@ static int stac92xx_init(struct hda_codec *codec)
 	unsigned int gpio;
 	int i;
 
-	snd_hda_sequence_write(codec, spec->init);
+	if (spec->init)
+		snd_hda_sequence_write(codec, spec->init);
 
 	/* power down adcs initially */
 	if (spec->powerdown_adcs)
@@ -5748,7 +5749,6 @@ again:
 		/* fallthru */
 	case 0x111d76b4: /* 6 Port without Analog Mixer */
 	case 0x111d76b5:
-		spec->init = stac92hd71bxx_core_init;
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		spec->num_dmics = stac92xx_connected_ports(codec,
 					stac92hd71bxx_dmic_nids,
@@ -5773,7 +5773,6 @@ again:
 			spec->stream_delay = 40; /* 40 milliseconds */
 
 		/* disable VSW */
-		spec->init = stac92hd71bxx_core_init;
 		unmute_init++;
 		snd_hda_codec_set_pincfg(codec, 0x0f, 0x40f000f0);
 		snd_hda_codec_set_pincfg(codec, 0x19, 0x40f000f3);
@@ -5788,7 +5787,6 @@ again:
 
 		/* fallthru */
 	default:
-		spec->init = stac92hd71bxx_core_init;
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		spec->num_dmics = stac92xx_connected_ports(codec,
 					stac92hd71bxx_dmic_nids,
@@ -5796,6 +5794,10 @@ again:
 		break;
 	}
 
+	if (codec->start_nid + codec->num_nodes >= 0x28 &&
+		get_wcaps_type(get_wcaps(codec, 0x28)) == AC_WID_VOL_KNB)
+		spec->init = stac92hd71bxx_core_init;
+
 	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
 		snd_hda_sequence_write_cache(codec, unmute_init);
 
-- 
1.7.9.5
