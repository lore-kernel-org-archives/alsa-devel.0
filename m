From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 1/4] hda: make standalone
	hdmi_fill_audio_infoframe()
Date: Wed, 19 Nov 2008 08:56:15 +0800
Message-ID: <20081119013904.680227709@linux.intel.com>
References: <20081119005614.431653658@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id A4A4E244EA
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 02:41:27 +0100 (CET)
Content-Disposition: inline; filename=alsa-infoframe-cleanup.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

code refactor: make a standalone function hdmi_fill_audio_infoframe().

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -246,24 +246,31 @@ static void hdmi_clear_dip_buffers(struc
 #endif
 }
 
+static void hdmi_fill_audio_infoframe(struct hda_codec *codec,
+					struct hdmi_audio_infoframe *ai)
+{
+	u8 *params = (u8 *)ai;
+	int i;
+
+	hdmi_debug_dip_size(codec);
+	hdmi_clear_dip_buffers(codec); /* be paranoid */
+
+	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
+	for (i = 0; i < sizeof(ai); i++)
+		hdmi_write_dip_byte(codec, PIN_NID, params[i]);
+}
+
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
-	struct hdmi_audio_infoframe audio_infoframe = {
+	struct hdmi_audio_infoframe ai = {
 		.type		= 0x84,
 		.ver		= 0x01,
 		.len		= 0x0a,
 		.CC02_CT47	= substream->runtime->channels - 1,
 	};
-	u8 *params = (u8 *)&audio_infoframe;
-	int i;
-
-	hdmi_debug_dip_size(codec);
-	hdmi_clear_dip_buffers(codec); /* be paranoid */
 
-	hdmi_set_dip_index(codec, PIN_NID, 0x0, 0x0);
-	for (i = 0; i < sizeof(audio_infoframe); i++)
-		hdmi_write_dip_byte(codec, PIN_NID, params[i]);
+	hdmi_fill_audio_infoframe(codec, &ai);
 }
 
 

-- 
