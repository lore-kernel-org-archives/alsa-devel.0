From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 1/6] ALSA: hda/ca0132: Delete pointless
	assignments to struct auto_pin_cfg fields
Date: Fri, 15 Jun 2018 21:56:15 -0400
Message-ID: <20180616015620.26663-2-alastair.bridgewater@gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

ca0132_config() was setting some values in the auto_pin_cfg for
the codec... but it is called prior to snd_hda_parse_pin_defcfg(),
which does a memset() to clear the entire structure as one of its
first actions, making the entire exercise pointless.

Kill all use of struct auto_pin_cfg from ca0132_config().

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 292e2c592c17..e03461aab68c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7343,7 +7343,6 @@ static const struct hda_codec_ops ca0132_patch_ops = {
 static void ca0132_config(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
 
 	spec->dacs[0] = 0x2;
 	spec->dacs[1] = 0x3;
@@ -7405,12 +7404,7 @@ static void ca0132_config(struct hda_codec *codec)
 		/* SPDIF I/O */
 		spec->dig_out = 0x05;
 		spec->multiout.dig_out_nid = spec->dig_out;
-		cfg->dig_out_pins[0] = 0x0c;
-		cfg->dig_outs = 1;
-		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
 		spec->dig_in = 0x09;
-		cfg->dig_in_pin = 0x0e;
-		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 		break;
 	case QUIRK_R3DI:
 		codec_dbg(codec, "%s: QUIRK_R3DI applied.\n", __func__);
@@ -7438,9 +7432,6 @@ static void ca0132_config(struct hda_codec *codec)
 		/* SPDIF I/O */
 		spec->dig_out = 0x05;
 		spec->multiout.dig_out_nid = spec->dig_out;
-		cfg->dig_out_pins[0] = 0x0c;
-		cfg->dig_outs = 1;
-		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
 		break;
 	default:
 		spec->num_outputs = 2;
@@ -7463,12 +7454,7 @@ static void ca0132_config(struct hda_codec *codec)
 		/* SPDIF I/O */
 		spec->dig_out = 0x05;
 		spec->multiout.dig_out_nid = spec->dig_out;
-		cfg->dig_out_pins[0] = 0x0c;
-		cfg->dig_outs = 1;
-		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
 		spec->dig_in = 0x09;
-		cfg->dig_in_pin = 0x0e;
-		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 		break;
 	}
 }
-- 
2.16.1
