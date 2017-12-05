From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH] ASoC: Intel: bxt: Refine the HW contraint of
	Ref capture.
Date: Wed,  6 Dec 2017 03:21:27 +0800
Message-ID: <20171205192127.16210-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from E6440 (123-192-241-158.dynamic.kbronet.com.tw [123.192.241.158])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D6426698E
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 20:22:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-audio-intel@eclists.intel.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tiwai@suse.com, Harry Pan <harry.pan@intel.com>, broonie@kernel.org, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, Adam.Thomson.Opensource@diasemi.com, harshapriya.n@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The patch restricts the HW contraint of the refcap of WoV stream
in single channel (mono) and 16k Hz based on platform implementation.

Such that, the userspace program can rely on correct HW parameters
through the ALSA library call to manipulate the device.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index ce35ec7884d1..382f71228807 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -338,8 +338,23 @@ static const struct snd_pcm_hw_constraint_list constraints_16000 = {
 	.list  = rates_16000,
 };
 
+static const unsigned int ch_mono[] = {
+	1,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_refcap = {
+	.count = ARRAY_SIZE(ch_mono),
+	.list  = ch_mono,
+};
+
 static int broxton_refcap_startup(struct snd_pcm_substream *substream)
 {
+	substream->runtime->hw.channels_max = 1;
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_CHANNELS,
+					&constraints_refcap);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE,
 			&constraints_16000);
-- 
2.13.5
