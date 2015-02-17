From: libin.yang@intel.com
Subject: [PATCH] ASoC: Intel: add SNDRV_PCM_INFO_DRAIN_TRIGGER
	flag
Date: Tue, 17 Feb 2015 12:28:23 +0800
Message-ID: <1424147303-92196-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 21FFA26087E
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 05:34:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@sirena.org.uk
Cc: libin.yang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Add SNDRV_PCM_INFO_DRAIN_TRIGGER in snd_pcm_hardware.info to
call sst_hsw_stream_set_silence_start() when PCM draining.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index d6fa9d5..7e21e8f 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -91,7 +91,8 @@ static const struct snd_pcm_hardware hsw_pcm_hardware = {
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_RESUME |
-				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
+				  SNDRV_PCM_INFO_DRAIN_TRIGGER,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= PAGE_SIZE,
-- 
1.9.1
