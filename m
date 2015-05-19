From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Add headset-mode* model
	options for ALC269 & co
Date: Tue, 19 May 2015 10:23:07 +0200
Message-ID: <1432023788-1666-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6760A260692
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 10:23:09 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 29D24ACC2
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 08:23:09 +0000 (UTC)
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

Modern machines tend to have only one headset jack nowadays, and they
often need these quirks.  Let's allow them applicable via model
option for ease of debugging.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt | 2 ++
 sound/pci/hda/patch_realtek.c                | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 5a3163cac6c3..d92b85d38adc 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -29,6 +29,8 @@ ALC269/270/275/276/28x/29x
   alc271-dmic		Enable ALC271X digital mic workaround
   inv-dmic		Inverted internal mic workaround
   headset-mic		Indicates a combined headset (headphone+mic) jack
+  headset-mode		More comprehensive headset support for ALC269 & co
+  headset-mode-no-hp-mic Headset mode support without headphone mic
   lenovo-dock   	Enables docking station I/O for some Lenovos
   dell-headset-multi	Headset jack, which can also be used as mic-in
   dell-headset-dock	Headset jack (without mic-in), and also dock I/O
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6e1c8c34e841..4d11fbfca5e2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5242,6 +5242,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC271_FIXUP_DMIC, .name = "alc271-dmic"},
 	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
 	{.id = ALC269_FIXUP_HEADSET_MIC, .name = "headset-mic"},
+	{.id = ALC269_FIXUP_HEADSET_MODE, .name = "headset-mode"},
+	{.id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC, .name = "headset-mode-no-hp-mic"},
 	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
 	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
-- 
2.4.1
