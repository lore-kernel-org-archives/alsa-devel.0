From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ab8500: Explicitly set I/O up
Date: Tue, 24 Sep 2013 11:56:03 +0100
Message-ID: <1380020163-20496-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FB8E2652D3
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 12:56:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>, linus.walleij@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

We do some I/O in probe so we need to ensure the I/O operations are fully
set up then.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index ca500fd..a0394a8 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2473,6 +2473,8 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
+	snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+
 	/* Setup AB8500 according to board-settings */
 	pdata = dev_get_platdata(dev->parent);
 
-- 
1.8.4.rc3
