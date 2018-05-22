From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda/conexant - Add hp-mic-fix model
	string
Date: Tue, 22 May 2018 13:46:17 +0200
Message-ID: <20180522114617.26483-2-tiwai@suse.de>
References: <20180522114617.26483-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4532C26765C
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 13:46:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5159FADDC
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 11:46:20 +0000 (UTC)
In-Reply-To: <20180522114617.26483-1-tiwai@suse.de>
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

Add "hp-mic-fix" model string for Conexant codecs so that user can
test the quirk without recompiling.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 sound/pci/hda/patch_conexant.c          | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 1fee5a4f6660..7c2d37571af0 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -263,6 +263,8 @@ hp-dock
     HP dock support
 mute-led-gpio
     Mute LED control via GPIO
+hp-mic-fix
+    Fix for headset mic pin on HP boxes
 
 STAC9200
 ========
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index dad7e9d5e5a6..dbf9910c5269 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -998,6 +998,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_MUTE_LED_EAPD, .name = "mute-led-eapd" },
 	{ .id = CXT_FIXUP_HP_DOCK, .name = "hp-dock" },
 	{ .id = CXT_FIXUP_MUTE_LED_GPIO, .name = "mute-led-gpio" },
+	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{}
 };
 
-- 
2.16.3
