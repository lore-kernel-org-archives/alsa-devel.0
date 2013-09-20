From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: ab8500: Use ASoC I/O functions
Date: Fri, 20 Sep 2013 10:39:18 +0100
Message-ID: <1379669959-21517-2-git-send-email-broonie@kernel.org>
References: <1379669959-21517-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 23639261A2F
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 11:40:29 +0200 (CEST)
In-Reply-To: <1379669959-21517-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

In preparation for moving away from implementing the ASoC level register
I/O functionality change direct calls to the ab8500 implementation of that
to use snd_soc_write()

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 2726e5a..7990217 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2532,12 +2532,10 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Override HW-defaults */
-	ab8500_codec_write_reg(codec,
-				AB8500_ANACONF5,
-				BIT(AB8500_ANACONF5_HSAUTOEN));
-	ab8500_codec_write_reg(codec,
-				AB8500_SHORTCIRCONF,
-				BIT(AB8500_SHORTCIRCONF_HSZCDDIS));
+	snd_soc_write(codec, AB8500_ANACONF5,
+		      BIT(AB8500_ANACONF5_HSAUTOEN));
+	snd_soc_write(codec, AB8500_SHORTCIRCONF,
+		      BIT(AB8500_SHORTCIRCONF_HSZCDDIS));
 
 	/* Add filter controls */
 	status = snd_soc_add_codec_controls(codec, ab8500_filter_controls,
-- 
1.8.4.rc3
