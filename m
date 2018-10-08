From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 1/4] ALSA: hda/ca0132 - Fix microphone inconsistency issues
Date: Mon,  8 Oct 2018 15:39:57 -0400
Message-ID: <1539027601-20910-2-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes microphone inconsistency issues by adding a delay to
each setup_defaults function. Without this, the microphone only works
intermittently.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b098504..12a3581 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7223,6 +7223,8 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7267,6 +7269,8 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7324,6 +7328,8 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-- 
2.7.4
