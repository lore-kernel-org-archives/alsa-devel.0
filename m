From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ab8500: Mark expected switch
	fall-through" to the asoc tree
Date: Mon,  4 Mar 2019 00:06:09 +0000 (GMT)
Message-ID: <20190304000609.F1B0A440082@finisterre.ee.mobilebroadband>
References: <20190301204310.GA19966@embeddedor>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2622539693465874866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF759F89714
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 01:06:17 +0100 (CET)
In-Reply-To: <20190301204310.GA19966@embeddedor>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============2622539693465874866==
Content-Type: text/plain

The patch

   ASoC: ab8500: Mark expected switch fall-through

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

>From 102cefc8e879b707be0024fdc7bce1deeb359a5f Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 1 Mar 2019 14:43:10 -0600
Subject: [PATCH] ASoC: ab8500: Mark expected switch fall-through
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

In file included from sound/soc/codecs/ab8500-codec.c:24:
sound/soc/codecs/ab8500-codec.c: In function ‘ab8500_codec_set_dai_fmt’:
./include/linux/device.h:1485:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/ab8500-codec.c:2129:3: note: in expansion of macro ‘dev_err’
   dev_err(dai->component->dev,
   ^~~~~~~
sound/soc/codecs/ab8500-codec.c:2132:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 03bbbcd3b6c1..87616b126018 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2129,6 +2129,7 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_err(dai->component->dev,
 			"%s: ERROR: The device is either a master or a slave.\n",
 			__func__);
+		/* fall through */
 	default:
 		dev_err(dai->component->dev,
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
-- 
2.20.1


--===============2622539693465874866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2622539693465874866==--
