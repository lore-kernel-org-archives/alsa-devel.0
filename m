From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ASoC: adau1701: remove control_data
	assignment
Date: Thu, 27 Jun 2013 22:00:05 +0200
Message-ID: <1372363205-31244-2-git-send-email-zonque@gmail.com>
References: <1372363205-31244-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E45E126566D
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 21:59:35 +0200 (CEST)
In-Reply-To: <1372363205-31244-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

codec->control_data has to be left unset to make the ASoC core access
the regmap properly.

That bug slipped in during a rebase session of the driver refactoring.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/adau1701.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index ce56065..16e5555 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -599,8 +599,6 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	unsigned int val;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 
-	codec->control_data = to_i2c_client(codec->dev);
-
 	/*
 	 * Let the pll_clkdiv variable default to something that won't happen
 	 * at runtime. That way, we can postpone the firmware download from
-- 
1.8.1.4
