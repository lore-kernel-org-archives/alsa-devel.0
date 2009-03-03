From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/4] ASoC: Use network mode with 2 slots for
	16-bit stereo in pxa-ssp/Zylonite
Date: Tue,  3 Mar 2009 16:10:51 +0100
Message-ID: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id B16D610380E
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:10:58 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so84570fge.44
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 07:10:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

For consistency with 24-bit and 32-bit modes, don't send 16-bit stereo
in one 32-bit transfer. Use 2 slots instead on Zylonite. It should result
in exactly the same behaviour.
Now it is possible to use 16-bit single slot transfers in pxa-ssp, which
are needed for Magician to get two frame clock pulses per sample
(one for each channel).

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c  |    3 +--
 sound/soc/pxa/zylonite.c |    7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4a973ab..c49bb12 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -644,8 +644,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 			sscr0 |= SSCR0_FPCKE;
 #endif
 		sscr0 |= SSCR0_DataSize(16);
-		if (params_channels(params) > 1)
-			sscr0 |= SSCR0_EDSS;
+		/* use network mode (2 slots) for 16 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 0140a25..9f6116e 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -127,8 +127,11 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* We're not really in network mode but the emulation wants this. */
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
+	/* Use network mode for stereo, one slot per channel. */
+	if (params_channels(params) > 1)
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 2);
+	else
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.1.3
