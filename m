From: Jerome Anand <jerome.anand@intel.com>
Subject: [PATCH v4 5/5] ALSA: x86: hdmi: continue playback even
	when display resolution changes
Date: Sat, 21 Jan 2017 03:52:32 +0530
Message-ID: <20170120222232.27791-6-jerome.anand@intel.com>
References: <20170120222232.27791-1-jerome.anand@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2962D2666FE
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 11:21:07 +0100 (CET)
In-Reply-To: <20170120222232.27791-1-jerome.anand@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, jerome.anand@intel.com, ville.syrjala@linux.intel.com
List-Id: alsa-devel@alsa-project.org

When the display resolution changes, the drm disables the
display pipes due to which audio rendering stops. At this
time, we need to ensure the existing audio pointers and
buffers are cleared out so that the playback can restarted
once the display pipe is enabled with a different N/CTS values

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jerome Anand <jerome.anand@intel.com>
---
 sound/x86/intel_hdmi_audio.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index b69521a..f301554 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -43,6 +43,7 @@ static DEFINE_MUTEX(had_mutex);
 static int hdmi_card_index = SNDRV_DEFAULT_IDX1;
 static char *hdmi_card_id = SNDRV_DEFAULT_STR1;
 static struct snd_intelhad *had_data;
+static int underrun_count;
 
 module_param_named(index, hdmi_card_index, int, 0444);
 MODULE_PARM_DESC(index,
@@ -1052,6 +1053,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 	had_stream = intelhaddata->private_data;
 	runtime = substream->runtime;
+	underrun_count = 0;
 
 	pm_runtime_get(intelhaddata->dev);
 
@@ -1445,10 +1447,23 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 
 	buf_id = intelhaddata->curr_buf % 4;
 	had_read_register(AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH), &t);
-	if (t == 0) {
-		pr_debug("discovered buffer done for buf %d\n", buf_id);
-		/* had_process_buffer_done(intelhaddata); */
+
+	if ((t == 0) || (t == ((u32)-1L))) {
+		underrun_count++;
+		pr_debug("discovered buffer done for buf %d, count = %d\n",
+			buf_id, underrun_count);
+
+		if (underrun_count > (HAD_MIN_PERIODS/2)) {
+			pr_debug("assume audio_codec_reset, underrun = %d - do xrun\n",
+				underrun_count);
+			underrun_count = 0;
+			return SNDRV_PCM_POS_XRUN;
+		}
+	} else {
+		/* Reset Counter */
+		underrun_count = 0;
 	}
+
 	t = intelhaddata->buf_info[buf_id].buf_size - t;
 
 	if (intelhaddata->stream_info.buffer_rendered)
-- 
2.9.3
