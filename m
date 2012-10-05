From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V7 12/15] ALSA: HDA: Make hda sound card usable
	for Loongson
Date: Fri,  5 Oct 2012 21:25:09 +0800
Message-ID: <1349443512-18340-13-git-send-email-chenhc@lemote.com>
References: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F052616C1
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 15:27:05 +0200 (CEST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so1860033pbb.38
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2012 06:27:04 -0700 (PDT)
In-Reply-To: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org, Hongliang Tao <taohl@lemote.com>, Jie Chen <chenj@lemote.com>, Huacai Chen <chenhc@lemote.com>
List-Id: alsa-devel@alsa-project.org

Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
this patch modify patch_conexant.c to add Lemote specific code.

Both A1004 and A1205 use the same pin configurations, but A1004 need
to increase the default boost of internal mic.

Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/hda/patch_conexant.c |   44 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5e22a8f..3cc265e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4408,7 +4408,10 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 enum {
 	CXT_PINCFG_LENOVO_X200,
 	CXT_PINCFG_LENOVO_TP410,
+	CXT_PINCFG_LEMOTE_A1004,
+	CXT_PINCFG_LEMOTE_A1205,
 	CXT_FIXUP_STEREO_DMIC,
+	CXT_FIXUP_INC_MIC_BOOST,
 };
 
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
@@ -4418,6 +4421,19 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 	spec->fixup_stereo_dmic = 1;
 }
 
+static void cxt5066_increase_mic_boost(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_override_amp_caps(codec, 0x17, HDA_OUTPUT,
+				  (0x3 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x4 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x27 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (0 << AC_AMPCAP_MUTE_SHIFT));
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -4435,6 +4451,18 @@ static const struct hda_pintbl cxt_pincfg_lenovo_tp410[] = {
 	{}
 };
 
+/* Lemote A1004/A1205 with cxt5066 */
+static const struct hda_pintbl cxt_pincfg_lemote[] = {
+	{ 0x1a, 0x90a10020 }, /* Internal mic */
+	{ 0x1b, 0x03a11020 }, /* External mic */
+	{ 0x1d, 0x400101f0 }, /* Not used */
+	{ 0x1e, 0x40a701f0 }, /* Not used */
+	{ 0x20, 0x404501f0 }, /* Not used */
+	{ 0x22, 0x404401f0 }, /* Not used */
+	{ 0x23, 0x40a701f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -4444,10 +4472,24 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lenovo_tp410,
 	},
+	[CXT_PINCFG_LEMOTE_A1004] = {
+		.type = HDA_FIXUP_PINS,
+		.chained = true,
+		.chain_id = CXT_FIXUP_INC_MIC_BOOST,
+		.v.pins = cxt_pincfg_lemote,
+	},
+	[CXT_PINCFG_LEMOTE_A1205] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lemote,
+	},
 	[CXT_FIXUP_STEREO_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
 	},
+	[CXT_FIXUP_INC_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt5066_increase_mic_boost,
+	},
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
@@ -4463,6 +4505,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
+	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	{}
 };
 
-- 
1.7.7.3
