From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct handling of compressed
	streams that restart" to the asoc tree
Date: Tue, 19 Mar 2019 13:13:24 +0000 (GMT)
Message-ID: <20190319131324.09D2911288E0@debutante.sirena.org.uk>
References: <20190319115215.22960-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48F02F89716
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:25 +0100 (CET)
In-Reply-To: <20190319115215.22960-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct handling of compressed streams that restart

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 639e5eb3c7d67e407f2a71fccd95323751398f6f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:04 +0000
Subject: [PATCH] ASoC: wm_adsp: Correct handling of compressed streams that
 restart

Previously support was added to allow streams to be stopped and
started again without the DSP being power cycled and this was done
by clearing the buffer state in trigger start. Another supported
use-case is using the DSP for a trigger event then opening the
compressed stream later to receive the audio, unfortunately clearing
the buffer state in trigger start destroys the data received
from such a trigger. Correct this issue by moving the call to
wm_adsp_buffer_clear to be in trigger stop instead.

Fixes: 61fc060c40e6 ("ASoC: wm_adsp: Support streams which can start/stop with DSP active")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b93fdc8d2d6f..0de36b7eeeb2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3571,8 +3571,6 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 		if (ret < 0)
 			break;
 
-		wm_adsp_buffer_clear(compr->buf);
-
 		/* Trigger the IRQ at one fragment of data */
 		ret = wm_adsp_buffer_write(compr->buf,
 					   HOST_BUFFER_FIELD(high_water_mark),
@@ -3584,6 +3582,7 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
+		wm_adsp_buffer_clear(compr->buf);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.20.1
