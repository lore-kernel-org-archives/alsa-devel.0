From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda/realtek - Comprehensive model
	list for ALC262
Date: Tue, 26 Jun 2018 17:42:57 +0200
Message-ID: <20180626154258.31475-5-tiwai@suse.de>
References: <20180626154258.31475-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 25BE22678FC
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:43:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A91B5AFB8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 15:43:01 +0000 (UTC)
In-Reply-To: <20180626154258.31475-1-tiwai@suse.de>
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

Added a few missing entries for ALC262 model strings.
All about specific hardwares.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 16 ++++++++++++++++
 sound/pci/hda/patch_realtek.c           |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 323c25c53eaf..560235519555 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -34,6 +34,22 @@ ALC262
 ======
 inv-dmic
     Inverted internal mic workaround
+fsc-h270
+    Fixups for Fujitsu-Siemens Celsius H270
+fsc-s7110
+    Fixups for Fujitsu-Siemens Lifebook S7110
+hp-z200
+    Fixups for HP Z200
+tyan
+    Fixups for Tyan Thunder n6650W
+lenovo-3000
+    Fixups for Lenovo 3000
+benq
+    Fixups for Benq ED8
+benq-t31
+    Fixups for Benq T31
+bayleybay
+    Fixups for Intel BayleyBay
 
 ALC267/268
 ==========
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4eb124c9cae3..d4a231b92fcc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2558,6 +2558,14 @@ static const struct snd_pci_quirk alc262_fixup_tbl[] = {
 
 static const struct hda_model_fixup alc262_fixup_models[] = {
 	{.id = ALC262_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC262_FIXUP_FSC_H270, .name = "fsc-h270"},
+	{.id = ALC262_FIXUP_FSC_S7110, .name = "fsc-s7110"},
+	{.id = ALC262_FIXUP_HP_Z200, .name = "hp-z200"},
+	{.id = ALC262_FIXUP_TYAN, .name = "tyan"},
+	{.id = ALC262_FIXUP_LENOVO_3000, .name = "lenovo-3000"},
+	{.id = ALC262_FIXUP_BENQ, .name = "benq"},
+	{.id = ALC262_FIXUP_BENQ_T31, .name = "benq-t31"},
+	{.id = ALC262_FIXUP_INTEL_BAYLEYBAY, .name = "bayleybay"},
 	{}
 };
 
-- 
2.17.1
