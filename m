From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 50/53] ALSA: x86: Set CA bits for DisplayPort
	too
Date: Thu,  2 Feb 2017 18:03:04 +0100
Message-ID: <20170202170307.24484-52-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C5ED8266849
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a guess work.  Usually the DP audio info frame is just 8-bit
shifted from HDMI AI, so let's try to put CA in DIP frame 2 [24-31].

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index f49520117dd6..24a18b88c927 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -626,20 +626,20 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 	u8 checksum = 0;
 	u32 info_frame;
 	int channels;
+	int ca;
 
 	channels = substream->runtime->channels;
 
 	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.regval);
 
+	ca = snd_intelhad_channel_allocation(intelhaddata, channels);
 	if (intelhaddata->dp_output) {
 		info_frame = DP_INFO_FRAME_WORD1;
-		frame2.regval = 1;
+		frame2.regval = (substream->runtime->channels - 1) | (ca << 24);
 	} else {
 		info_frame = HDMI_INFO_FRAME_WORD1;
 		frame2.regx.chnl_cnt = substream->runtime->channels - 1;
-
-		frame3.regx.chnl_alloc = snd_intelhad_channel_allocation(
-			intelhaddata, channels);
+		frame3.regx.chnl_alloc = ca;
 
 		/* Calculte the byte wide checksum for all valid DIP words */
 		for (i = 0; i < BYTES_PER_WORD; i++)
-- 
2.11.0
