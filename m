From: mengdong.lin@intel.com
Subject: [PATCH 2/2] ALSA: hda - fixup ALC262 to remove depop
	delay on Intel BayleyBay board
Date: Fri, 29 Nov 2013 00:35:35 -0500
Message-ID: <723de287700bfd07eeadb2c7e010747ef273f7af.1385703143.git.mengdong.lin@intel.com>
References: <6b1ded4b9b806846c363a508ebbb9dc859ae1787.1385703143.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 334B0265577
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:32:08 +0100 (CET)
In-Reply-To: <6b1ded4b9b806846c363a508ebbb9dc859ae1787.1385703143.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch defines a fixup 'alc_fixup_no_depop_delay', which sets alc_spec flag
'no_depop_delay' to indicate skipping delay in Realtek codec suspend/resume.

And Intel Baytrail BayleyBay board applies this fixup to reduce driver
suspend/resume time.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 503cf78..46822e0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -369,6 +369,15 @@ static void alc_fixup_sku_ignore(struct hda_codec *codec,
 	}
 }
 
+static void alc_fixup_no_depop_delay(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PROBE)
+		spec->no_depop_delay = 1;
+}
+
 static int alc_auto_parse_customize_define(struct hda_codec *codec)
 {
 	unsigned int ass, tmp, i;
@@ -2298,6 +2307,7 @@ enum {
 	ALC262_FIXUP_BENQ,
 	ALC262_FIXUP_BENQ_T31,
 	ALC262_FIXUP_INV_DMIC,
+	ALC262_FIXUP_INTEL_BAYLEYBAY,
 };
 
 static const struct hda_fixup alc262_fixups[] = {
@@ -2362,6 +2372,10 @@ static const struct hda_fixup alc262_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC262_FIXUP_INTEL_BAYLEYBAY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_no_depop_delay,
+	},
 };
 
 static const struct snd_pci_quirk alc262_fixup_tbl[] = {
@@ -2373,6 +2387,7 @@ static const struct snd_pci_quirk alc262_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x384e, "Lenovo 3000", ALC262_FIXUP_LENOVO_3000),
 	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8", ALC262_FIXUP_BENQ),
 	SND_PCI_QUIRK(0x17ff, 0x058d, "Benq T31-16", ALC262_FIXUP_BENQ_T31),
+	SND_PCI_QUIRK(0x8086, 0x7270, "BayleyBay", ALC262_FIXUP_INTEL_BAYLEYBAY),
 	{}
 };
 
-- 
1.8.1.2
