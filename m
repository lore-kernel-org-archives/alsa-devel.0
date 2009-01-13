From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: stac92hd8xxx amp mixers
Date: Tue, 13 Jan 2009 13:30:07 -0500
Message-ID: <496CDDAF.7060406@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 91A4224131
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 19:30:20 +0100 (CET)
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

Added amp nid for stac92hd8xxx families of codecs so the input amp
mixer is created.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 35b83dc..dedf8b2 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -331,6 +331,10 @@ static unsigned int stac92hd83xxx_pwr_mapping[4] = {
 	0x03, 0x0c, 0x10, 0x40,
 };
 
+static unsigned int stac92hd83xxx_amp_nids[1] = {
+	0xc,
+};
+
 static hda_nid_t stac92hd71bxx_pwr_nids[3] = {
 	0x0a, 0x0d, 0x0f
 };
@@ -4672,6 +4676,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec->dmux_nids = stac92hd83xxx_dmux_nids;
 	spec->adc_nids = stac92hd83xxx_adc_nids;
 	spec->pwr_nids = stac92hd83xxx_pwr_nids;
+	spec->amp_nids = stac92hd83xxx_amp_nids;
 	spec->pwr_mapping = stac92hd83xxx_pwr_mapping;
 	spec->num_pwrs = ARRAY_SIZE(stac92hd83xxx_pwr_nids);
 	spec->multiout.dac_nids = spec->dac_nids;
@@ -4689,6 +4694,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec->num_pins = ARRAY_SIZE(stac92hd83xxx_pin_nids);
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd83xxx_dmux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd83xxx_adc_nids);
+	spec->num_amps = ARRAY_SIZE(stac92hd83xxx_amp_nids);
 	spec->num_dmics = STAC92HD83XXX_NUM_DMICS;
 	spec->dinput_mux = &stac92hd83xxx_dmux;
 	spec->pin_nids = stac92hd83xxx_pin_nids;
