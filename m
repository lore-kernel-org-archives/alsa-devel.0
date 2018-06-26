From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda/realtek - Comprehensive model
	list for ALC268
Date: Tue, 26 Jun 2018 17:42:56 +0200
Message-ID: <20180626154258.31475-4-tiwai@suse.de>
References: <20180626154258.31475-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24AA92678FA
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:43:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5B1DAFB7
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

Add the missing entry for ALC268 model strings.
Only "spdif" was missing, and that's it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 sound/pci/hda/patch_realtek.c           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index a403a7f34a78..323c25c53eaf 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -41,6 +41,8 @@ inv-dmic
     Inverted internal mic workaround
 hp-eapd
     Disable HP EAPD on NID 0x15
+spdif
+    Enable SPDIF output on NID 0x1e
 
 ALC22x/23x/25x/269/27x/28x/29x (and vendor-specific ALC3xxx models)
 ===================================================================
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index de77763e2725..4eb124c9cae3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2689,6 +2689,7 @@ static const struct hda_fixup alc268_fixups[] = {
 static const struct hda_model_fixup alc268_fixup_models[] = {
 	{.id = ALC268_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC268_FIXUP_HP_EAPD, .name = "hp-eapd"},
+	{.id = ALC268_FIXUP_SPDIF, .name = "spdif"},
 	{}
 };
 
-- 
2.17.1
