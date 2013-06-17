From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - Add models for Dell headset
	jacks
Date: Mon, 17 Jun 2013 11:04:02 +0200
Message-ID: <1371459843-3555-2-git-send-email-david.henningsson@canonical.com>
References: <1371459843-3555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBF5261A63
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 11:04:04 +0200 (CEST)
In-Reply-To: <1371459843-3555-1-git-send-email-david.henningsson@canonical.com>
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

These headset jacks keep coming in on more and more platforms, and
it's possible I don't catch them all. Make it easier to test and
verify by making models.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    3 +++
 sound/pci/hda/patch_realtek.c                |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index bb8b0dc..77d68e2 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -29,6 +29,8 @@ ALC269/270/275/276/280/282
   alc271-dmic	Enable ALC271X digital mic workaround
   inv-dmic	Inverted internal mic workaround
   lenovo-dock   Enables docking station I/O for some Lenovos
+  dell-headset-multi	Headset jack, which can also be used as mic-in
+  dell-headset-dock	Headset jack (without mic-in), and also dock I/O
 
 ALC662/663/272
 ==============
@@ -42,6 +44,7 @@ ALC662/663/272
   asus-mode7	ASUS
   asus-mode8	ASUS
   inv-dmic	Inverted internal mic workaround
+  dell-headset-multi	Headset jack, which can also be used as mic-in
 
 ALC680
 ======
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f5b1e51..ad087ea 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3610,6 +3610,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
+	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
+	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
 	{}
 };
 
@@ -4289,6 +4291,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_ASUS_MODE7, .name = "asus-mode7"},
 	{.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
 	{.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
 	{}
 };
 
-- 
1.7.9.5
