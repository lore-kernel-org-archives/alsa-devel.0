From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda/realtek - Comprehensive model
	list for ALC662 & co
Date: Tue, 26 Jun 2018 17:42:54 +0200
Message-ID: <20180626154258.31475-2-tiwai@suse.de>
References: <20180626154258.31475-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 225D92678F3
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:43:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9320FAE01
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

ALC662 and others have far more fixup entries than the model table.
Let's add more model string entries so that user can test / debug
without compiling kernels at each time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 36 +++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c           | 18 +++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 7c2d37571af0..f2f8402ff899 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -87,8 +87,14 @@ alc700-ref
 
 ALC66x/67x/892
 ==============
+aspire
+    Subwoofer pin fixup for Aspire laptops
+ideapad
+    Subwoofer pin fixup for Ideapad laptops
 mario
     Chromebook mario model fixup
+hp-rp5800
+    Headphone pin fixup for HP RP5800
 asus-mode1
     ASUS
 asus-mode2
@@ -105,10 +111,40 @@ asus-mode7
     ASUS
 asus-mode8
     ASUS
+zotac-z68
+    Front HP fixup for Zotac Z68
 inv-dmic
     Inverted internal mic workaround
+alc662-headset-multi
+    Dell headset jack, which can also be used as mic-in (ALC662)
 dell-headset-multi
     Headset jack, which can also be used as mic-in
+alc662-headset
+    Headset mode support on ALC662
+alc668-headset
+    Headset mode support on ALC668
+bass16
+    Bass speaker fixup on pin 0x16
+bass1a
+    Bass speaker fixup on pin 0x1a
+automute
+    Auto-mute fixups for ALC668
+dell-xps13
+    Dell XPS13 fixups
+asus-nx50
+    ASUS Nx50 fixups
+asus-nx51
+    ASUS Nx51 fixups
+alc891-headset
+    Headset mode support on ALC891
+alc891-headset-multi
+    Dell headset jack, which can also be used as mic-in (ALC891)
+acer-veriton
+    Acer Veriton speaker pin fixup
+asrock-mobo
+    Fix invalid 0x15 / 0x16 pins
+usi-headset
+    Headset support on USI machines
 dual-codecs
     Lenovo laptops with dual codecs
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3170e4b672ea..ba23f766e945 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8020,7 +8020,10 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 };
 
 static const struct hda_model_fixup alc662_fixup_models[] = {
+	{.id = ALC662_FIXUP_ASPIRE, .name = "aspire"},
+	{.id = ALC662_FIXUP_IDEAPAD, .name = "ideapad"},
 	{.id = ALC272_FIXUP_MARIO, .name = "mario"},
+	{.id = ALC662_FIXUP_HP_RP5800, .name = "hp-rp5800"},
 	{.id = ALC662_FIXUP_ASUS_MODE1, .name = "asus-mode1"},
 	{.id = ALC662_FIXUP_ASUS_MODE2, .name = "asus-mode2"},
 	{.id = ALC662_FIXUP_ASUS_MODE3, .name = "asus-mode3"},
@@ -8029,8 +8032,23 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_ASUS_MODE6, .name = "asus-mode6"},
 	{.id = ALC662_FIXUP_ASUS_MODE7, .name = "asus-mode7"},
 	{.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
+	{.id = ALC662_FIXUP_ZOTAC_Z68, .name = "zotac-z68"},
 	{.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC662_FIXUP_DELL_MIC_NO_PRESENCE, .name = "alc662-headset-multi"},
 	{.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
+	{.id = ALC662_FIXUP_HEADSET_MODE, .name = "alc662-headset"},
+	{.id = ALC668_FIXUP_HEADSET_MODE, .name = "alc668-headset"},
+	{.id = ALC662_FIXUP_BASS_16, .name = "bass16"},
+	{.id = ALC662_FIXUP_BASS_1A, .name = "bass1a"},
+	{.id = ALC668_FIXUP_AUTO_MUTE, .name = "automute"},
+	{.id = ALC668_FIXUP_DELL_XPS13, .name = "dell-xps13"},
+	{.id = ALC662_FIXUP_ASUS_Nx50, .name = "asus-nx50"},
+	{.id = ALC668_FIXUP_ASUS_Nx51, .name = "asus-nx51"},
+	{.id = ALC891_FIXUP_HEADSET_MODE, .name = "alc891-headset"},
+	{.id = ALC891_FIXUP_DELL_MIC_NO_PRESENCE, .name = "alc891-headset-multi"},
+	{.id = ALC662_FIXUP_ACER_VERITON, .name = "acer-veriton"},
+	{.id = ALC892_FIXUP_ASROCK_MOBO, .name = "asrock-mobo"},
+	{.id = ALC662_FIXUP_USI_HEADSET_MODE, .name = "usi-headset"},
 	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{}
 };
-- 
2.17.1
