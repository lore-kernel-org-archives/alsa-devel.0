From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 51/53] ALSA: x86: Simplify comments
Date: Thu,  2 Feb 2017 18:03:05 +0100
Message-ID: <20170202170307.24484-53-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BE326759C
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

It's a stand-alone small driver code, and we don't have to describe
too much formalized comments in kernel-doc style for local functions
at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 66 ++++++++++----------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 24a18b88c927..5613c675ce70 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -609,11 +609,7 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 }
 
 /*
- * snd_intelhad_prog_dip - to initialize Data Island Packets registers
- *
- * @substream:substream for which the prepare function is called
- * @intelhaddata:substream private data
- *
+ * Initialize Data Island Packets registers
  * This function is called in the prepare callback
  */
 static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
@@ -666,10 +662,7 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 }
 
 /*
- * snd_intelhad_prog_buffer - programs buffer address and length registers
- * @substream: substream for which the prepare function is called
- * @intelhaddata: substream private data
- *
+ * Programs buffer address and length registers
  * This function programs ring buffer address and length into registers.
  */
 static int snd_intelhad_prog_buffer(struct snd_pcm_substream *substream,
@@ -824,7 +817,7 @@ static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
 }
 
 /*
- * snd_intelhad_prog_cts - Program HDMI audio CTS value
+ * Program HDMI audio CTS value
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @tmds: sampling frequency of the display data
@@ -896,7 +889,7 @@ static int had_calculate_n_value(u32 aud_samp_freq)
 }
 
 /*
- * snd_intelhad_prog_n - Program HDMI audio N value
+ * Program HDMI audio N value
  *
  * @aud_samp_freq: sampling frequency of audio data
  * @n_param: N value, depends on aud_samp_freq
@@ -962,10 +955,7 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 }
 
 /*
- * snd_intelhad_open - stream initializations are done here
- * @substream:substream for which the stream function is called
- *
- * This function is called whenever a PCM stream is opened
+ * ALSA PCM open callback
  */
 static int snd_intelhad_open(struct snd_pcm_substream *substream)
 {
@@ -1017,10 +1007,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 }
 
 /*
- * snd_intelhad_close - to free parameteres when stream is stopped
- * @substream:  substream for which the function is called
- *
- * This function is called by ALSA framework when stream is stopped
+ * ALSA PCM close callback
  */
 static int snd_intelhad_close(struct snd_pcm_substream *substream)
 {
@@ -1051,12 +1038,7 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 }
 
 /*
- * snd_intelhad_hw_params - to setup the hardware parameters
- *   like allocating the buffers
- * @substream: substream for which the function is called
- * @hw_params: hardware parameters
- *
- * This function is called by ALSA framework when hardware params are set
+ * ALSA PCM hw_params callback
  */
 static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *hw_params)
@@ -1090,11 +1072,7 @@ static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
 }
 
 /*
- * snd_intelhad_hw_free - to release the resources allocated during
- *   hardware params setup
- * @substream:  substream for which the function is called
- *
- * This function is called by ALSA framework before close callback.
+ * ALSA PCM hw_free callback
  */
 static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 {
@@ -1113,11 +1091,7 @@ static int snd_intelhad_hw_free(struct snd_pcm_substream *substream)
 }
 
 /*
- * snd_intelhad_pcm_trigger - stream activities are handled here
- * @substream: substream for which the stream function is called
- * @cmd: the stream commamd thats requested from upper layer
- *
- * This function is called whenever an a stream activity is invoked
+ * ALSA PCM trigger callback
  */
 static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
@@ -1172,10 +1146,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 }
 
 /*
- * snd_intelhad_pcm_prepare - internal preparation before starting a stream
- * @substream: substream for which the function is called
- *
- * This function is called when a stream is started for internal preparation.
+ * ALSA PCM prepare callback
  */
 static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 {
@@ -1243,14 +1214,10 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 }
 
 /*
- * snd_intelhad_pcm_pointer- to send the current buffer pointerprocessed by hw
- * @substream: substream for which the function is called
- *
- * This function is called by ALSA framework to get the current hw buffer ptr
- * when a period is elapsed
+ * ALSA PCM pointer callback
  */
-static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
-					struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t
+snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 	u32 bytes_rendered = 0;
@@ -1299,12 +1266,7 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 }
 
 /*
- * snd_intelhad_pcm_mmap- mmaps a kernel buffer to user space for copying data
- * @substream: substream for which the function is called
- * @vma: struct instance of memory VMM memory area
- *
- * This function is called by OS when a user space component
- * tries to get mmap memory from driver
+ * ALSA PCM mmap callback
  */
 static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
-- 
2.11.0
