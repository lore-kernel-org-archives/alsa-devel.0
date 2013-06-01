From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: pcm: Require both CODEC and CPU support
	when declaring stream caps
Date: Sat,  1 Jun 2013 23:16:16 +0100
Message-ID: <1370124976-25047-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 32503265579
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 00:16:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

When declaring playback and capture capabilities check for both CODEC
side and CPU side support rather than only checking for CODEC side
support.  While it is unusual some CPUs do have unidirectional DAIs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 73bb8ee..a9fddf0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2011,9 +2011,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		if (cpu_dai->driver->capture.channels_min)
 			capture = 1;
 	} else {
-		if (codec_dai->driver->playback.channels_min)
+		if (codec_dai->driver->playback.channels_min &&
+		    cpu_dai->driver->playback.channels_min)
 			playback = 1;
-		if (codec_dai->driver->capture.channels_min)
+		if (codec_dai->driver->capture.channels_min &&
+		    cpu_dai->driver->capture.channels_min)
 			capture = 1;
 	}
 
-- 
1.7.10.4
