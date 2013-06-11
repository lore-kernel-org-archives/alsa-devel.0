From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Add models for Dell headset
	jacks
Date: Tue, 11 Jun 2013 11:06:49 +0200
Message-ID: <1370941609-5056-2-git-send-email-david.henningsson@canonical.com>
References: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E693E261A56
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 11:06:50 +0200 (CEST)
In-Reply-To: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
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
Cc: 1189363@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

These headset jacks keep coming in on more and more platforms, and
it's possible I don't catch them all. Make it easier to test and
verify by making models.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |   41 ++++++++++++++------------
 sound/pci/hda/patch_realtek.c                |    3 ++
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index bb8b0dc..9a0927c 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -21,27 +21,30 @@ ALC267/268
 ==========
   inv-dmic	Inverted internal mic workaround
 
-ALC269/270/275/276/280/282
+ALC269/270/275/276/28x/29x
 ======
-  laptop-amic	Laptops with analog-mic input
-  laptop-dmic	Laptops with digital-mic input
-  alc269-dmic	Enable ALC269(VA) digital mic workaround
-  alc271-dmic	Enable ALC271X digital mic workaround
-  inv-dmic	Inverted internal mic workaround
-  lenovo-dock   Enables docking station I/O for some Lenovos
-
-ALC662/663/272
+  laptop-amic		Laptops with analog-mic input
+  laptop-dmic		Laptops with digital-mic input
+  alc269-dmic		Enable ALC269(VA) digital mic workaround
+  alc271-dmic		Enable ALC271X digital mic workaround
+  inv-dmic		Inverted internal mic workaround
+  lenovo-dock		Enables docking station I/O for some Lenovos
+  dell-headset-multi	Headset jack, which can also be used as mic-in
+  dell-headset-dock	Headset jack (without mic-in), and also dock I/O
+
+ALC662/663/668/272
 ==============
-  mario		Chromebook mario model fixup
-  asus-mode1	ASUS
-  asus-mode2	ASUS
-  asus-mode3	ASUS
-  asus-mode4	ASUS
-  asus-mode5	ASUS
-  asus-mode6	ASUS
-  asus-mode7	ASUS
-  asus-mode8	ASUS
-  inv-dmic	Inverted internal mic workaround
+  mario			Chromebook mario model fixup
+  asus-mode1		ASUS
+  asus-mode2		ASUS
+  asus-mode3		ASUS
+  asus-mode4		ASUS
+  asus-mode5		ASUS
+  asus-mode6		ASUS
+  asus-mode7		ASUS
+  asus-mode8		ASUS
+  inv-dmic		Inverted internal mic workaround
+  dell-headset-multi	Headset jack, which can also be used as mic-in
 
 ALC680
 ======
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index af9e71b..403010c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3599,6 +3599,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
+	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
+	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
 	{}
 };
 
@@ -4278,6 +4280,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_ASUS_MODE7, .name = "asus-mode7"},
 	{.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
 	{.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
 	{}
 };
 
-- 
1.7.9.5
