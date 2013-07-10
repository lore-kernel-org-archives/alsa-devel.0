From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: pcm3008: Check for platform data
Date: Wed, 10 Jul 2013 16:54:59 +0100
Message-ID: <1373471700-24119-3-git-send-email-broonie@kernel.org>
References: <1373471700-24119-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E4EB2657AF
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:06:05 +0200 (CEST)
In-Reply-To: <1373471700-24119-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The driver will crash if none is provided.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 8ab1c03..4fa4ded 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -92,6 +92,9 @@ static int pcm3008_codec_probe(struct platform_device *pdev)
 	struct pcm3008_setup_data *setup = pdev->dev.platform_data;
 	int ret;
 
+	if (!setup)
+		return -EINVAL;
+
 	/* DEM1  DEM0  DE-EMPHASIS_MODE
 	 * Low   Low   De-emphasis 44.1 kHz ON
 	 * Low   High  De-emphasis OFF
-- 
1.8.3.2
