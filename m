From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Fix setting digital interface
	format" to the asoc tree
Date: Mon, 20 Jul 2015 18:52:09 +0100
Message-ID: <E1ZHFEX-0002rI-9g@debutante>
References: <1437316969.9569.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1767644408213446796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEEF72614CD
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:15 +0200 (CEST)
In-Reply-To: <1437316969.9569.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1767644408213446796==
Content-Type: text/plain

The patch

   ASoC: cs4349: Fix setting digital interface format

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From da304ac37efc1900892b5067c65f0ab8acfe3955 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 19 Jul 2015 22:42:49 +0800
Subject: [PATCH] ASoC: cs4349: Fix setting digital interface format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mode Control - Register 02h

Digital Interface Format (DIF[2:0]) Bits 6-4

DIF2    DIF1    DIF0    Description
0       0       0       Left-Justified, up to 24-bit data
0       0       1       I²S, up to 24-bit data
0       1       0       Right-Justified, 16-bit data
0       1       1       Right-Justified, 24-bit data
1       0       0       TDM slot 0
1       0       1       TDM slot 1
1       1       0       TDM slot 2
1       1       1       TDM slot 3

The DIF_MASK is 0x70, so current code does not correctly set the DIFx
setting. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index ab071675357e..4885695e35a7 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -96,17 +96,16 @@ static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
-	int mode, fmt, ret;
+	int fmt, ret;
 
-	mode = snd_soc_read(codec, CS4349_MODE);
 	cs4349->rate = params_rate(params);
 
 	switch (cs4349->mode) {
 	case SND_SOC_DAIFMT_I2S:
-		mode |= MODE_FORMAT(DIF_I2S);
+		fmt = DIF_I2S;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		mode |= MODE_FORMAT(DIF_LEFT_JST);
+		fmt = DIF_LEFT_JST;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		switch (params_width(params)) {
@@ -119,13 +118,13 @@ static int cs4349_pcm_hw_params(struct snd_pcm_substream *substream,
 		default:
 			return -EINVAL;
 		}
-		mode |= MODE_FORMAT(fmt);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	ret = snd_soc_write(codec, CS4349_MODE, mode);
+	ret = snd_soc_update_bits(codec, CS4349_MODE, DIF_MASK,
+				  MODE_FORMAT(fmt));
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4


--===============1767644408213446796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1767644408213446796==--
