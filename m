From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: ak4104: Use snd_soc_write() rather
	than internal write function
Date: Fri, 17 Feb 2012 12:23:11 -0800
Message-ID: <1329510192-4442-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
	<1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C762103FEB
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:23:20 +0100 (CET)
In-Reply-To: <1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index d6d9e40..34a840c 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -148,7 +148,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
 	val |= IEC958_AES0_CON_NOT_COPYRIGHT;
-	ak4104_spi_write(codec, AK4104_REG_CHN_STATUS(0), val);
+	snd_soc_write(codec, AK4104_REG_CHN_STATUS(0), val);
 
 	val = 0;
 
@@ -167,7 +167,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return ak4104_spi_write(codec, AK4104_REG_CHN_STATUS(3), val);
+	return snd_soc_write(codec, AK4104_REG_CHN_STATUS(3), val);
 }
 
 static const struct snd_soc_dai_ops ak4101_dai_ops = {
-- 
1.7.9
