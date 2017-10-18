From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add model string for Intel
	reference board quirk
Date: Wed, 18 Oct 2017 14:03:42 +0200
Message-ID: <20171018120342.12956-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C98DE267411
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 14:03:46 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EB943ABE2
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 12:03:44 +0000 (UTC)
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

For allowing user to apply the existing quirk on a machine with a
different SSID, add a new model string entry, alc700-ref.
The quirk itself was introduced in the commit b84e843644f2: "ALSA:
hda/realtek - Enable jack detection function for Intel ALC700")

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 sound/pci/hda/patch_realtek.c           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 773d2bfacc6c..1fee5a4f6660 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -82,6 +82,8 @@ tpt460
     Lenovo Thinkpad T460/560 setup
 dual-codecs
     Lenovo laptops with dual codecs
+alc700-ref
+    Intel reference board with ALC700 codec
 
 ALC66x/67x/892
 ==============
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ce71111b4e3..1a0163b81f5b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6357,6 +6357,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC292_FIXUP_TPT440, .name = "tpt440"},
 	{.id = ALC292_FIXUP_TPT460, .name = "tpt460"},
 	{.id = ALC233_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
+	{.id = ALC700_FIXUP_INTEL_REFERENCE, .name = "alc700-ref"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.14.2
