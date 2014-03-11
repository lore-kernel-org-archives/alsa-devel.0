From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 resend 0/3] Simplify the CODEC ASoC probe
	code.
Date: Tue, 11 Mar 2014 12:43:19 +0800
Message-ID: <1394513002-21946-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id DFA762608B7
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 06:51:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>, lars@metafoo.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Resend this patch series, and this resend ones are based Lars's following
patches:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073785.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073786.html



Xiubo Li (3):
  ASoC: codec: Simplify ASoC probe code.
  ASoC: io: New signature for snd_soc_codec_set_cache_io()
  ASoC: core: Fix check before setting default I/O up try regmap

 include/sound/soc.h               |  7 +-----
 sound/soc/codecs/88pm860x-codec.c |  3 +--
 sound/soc/codecs/ad193x.c         | 10 +--------
 sound/soc/codecs/adau1373.c       |  7 ------
 sound/soc/codecs/adav80x.c        |  7 ------
 sound/soc/codecs/ak4535.c         |  9 --------
 sound/soc/codecs/ak4641.c         |  8 -------
 sound/soc/codecs/ak4642.c         |  8 -------
 sound/soc/codecs/ak4671.c         | 12 +---------
 sound/soc/codecs/alc5623.c        |  7 ------
 sound/soc/codecs/alc5632.c        |  8 -------
 sound/soc/codecs/cq93vc.c         |  3 +--
 sound/soc/codecs/cs4270.c         |  9 --------
 sound/soc/codecs/cs42l51.c        |  6 -----
 sound/soc/codecs/cs42l52.c        |  9 +-------
 sound/soc/codecs/cs42l73.c        | 11 +--------
 sound/soc/codecs/da7210.c         |  8 -------
 sound/soc/codecs/da7213.c         |  8 -------
 sound/soc/codecs/da732x.c         | 13 ++---------
 sound/soc/codecs/da9055.c         |  8 -------
 sound/soc/codecs/isabelle.c       | 16 -------------
 sound/soc/codecs/lm49453.c        | 17 --------------
 sound/soc/codecs/max9768.c        |  5 -----
 sound/soc/codecs/max98088.c       |  6 -----
 sound/soc/codecs/max98090.c       |  8 -------
 sound/soc/codecs/max98095.c       |  6 -----
 sound/soc/codecs/max9850.c        |  8 -------
 sound/soc/codecs/mc13783.c        |  4 ++--
 sound/soc/codecs/ml26124.c        | 10 ---------
 sound/soc/codecs/rt5631.c         |  9 --------
 sound/soc/codecs/rt5640.c         |  8 -------
 sound/soc/codecs/si476x.c         |  6 +++--
 sound/soc/codecs/sn95031.c        |  2 --
 sound/soc/codecs/ssm2518.c        | 10 ---------
 sound/soc/codecs/ssm2602.c        |  7 ------
 sound/soc/codecs/sta32x.c         | 14 ------------
 sound/soc/codecs/sta529.c         | 10 ---------
 sound/soc/codecs/tlv320aic23.c    |  8 -------
 sound/soc/codecs/tlv320aic26.c    |  2 --
 sound/soc/codecs/tlv320aic32x4.c  |  2 --
 sound/soc/codecs/tlv320aic3x.c    |  6 -----
 sound/soc/codecs/tlv320dac33.c    |  1 -
 sound/soc/codecs/wm2000.c         |  2 --
 sound/soc/codecs/wm2200.c         |  7 ------
 sound/soc/codecs/wm5100.c         |  7 ------
 sound/soc/codecs/wm5102.c         |  4 +---
 sound/soc/codecs/wm5110.c         |  3 +--
 sound/soc/codecs/wm8350.c         |  4 +---
 sound/soc/codecs/wm8400.c         |  3 +--
 sound/soc/codecs/wm8510.c         | 10 +--------
 sound/soc/codecs/wm8523.c         |  7 ------
 sound/soc/codecs/wm8580.c         |  6 -----
 sound/soc/codecs/wm8711.c         |  6 -----
 sound/soc/codecs/wm8728.c         | 11 +--------
 sound/soc/codecs/wm8731.c         |  7 ------
 sound/soc/codecs/wm8737.c         |  6 -----
 sound/soc/codecs/wm8741.c         |  6 -----
 sound/soc/codecs/wm8750.c         |  6 -----
 sound/soc/codecs/wm8753.c         |  7 ------
 sound/soc/codecs/wm8770.c         |  6 -----
 sound/soc/codecs/wm8776.c         |  6 -----
 sound/soc/codecs/wm8804.c         |  8 -------
 sound/soc/codecs/wm8900.c         |  8 +------
 sound/soc/codecs/wm8903.c         | 10 +--------
 sound/soc/codecs/wm8904.c         |  9 --------
 sound/soc/codecs/wm8940.c         |  6 -----
 sound/soc/codecs/wm8955.c         |  8 -------
 sound/soc/codecs/wm8960.c         |  6 -----
 sound/soc/codecs/wm8961.c         |  7 ------
 sound/soc/codecs/wm8962.c         |  7 ------
 sound/soc/codecs/wm8971.c         |  6 -----
 sound/soc/codecs/wm8974.c         |  6 -----
 sound/soc/codecs/wm8978.c         |  8 +------
 sound/soc/codecs/wm8983.c         |  6 -----
 sound/soc/codecs/wm8985.c         |  7 ------
 sound/soc/codecs/wm8988.c         |  8 -------
 sound/soc/codecs/wm8990.c         |  8 -------
 sound/soc/codecs/wm8991.c         |  8 -------
 sound/soc/codecs/wm8993.c         |  7 ------
 sound/soc/codecs/wm8994.c         |  3 +--
 sound/soc/codecs/wm8995.c         |  7 ------
 sound/soc/codecs/wm8996.c         | 12 +---------
 sound/soc/codecs/wm8997.c         |  4 +---
 sound/soc/codecs/wm9081.c         | 11 +--------
 sound/soc/codecs/wm9090.c         | 10 ---------
 sound/soc/soc-core.c              | 12 +++++++---
 sound/soc/soc-io.c                | 47 +++++++++++++++++----------------------
 87 files changed, 57 insertions(+), 622 deletions(-)

-- 
1.8.4
