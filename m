From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Clear BIT_CLK_MASTER
 and WORD_CLK_MASTER bits for for slave mode
Date: Thu, 27 Oct 2011 16:38:42 +0800
Message-ID: <1319704722.2673.5.camel@phoenix>
References: <1319704549.2673.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E2D0246A1
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 10:38:49 +0200 (CEST)
Received: by gyg8 with SMTP id 8so2853260gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2011 01:38:49 -0700 (PDT)
In-Reply-To: <1319704549.2673.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, Jarkko@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet:

Page0 / Register8: Audio Serial Data interface Control Register A
BIT 7: Bit Clock Directional Control
        0: Bit clock is an input (slave mode)
        1: Bit clock is an output (master mode)

BIT 6: Word Clock Directional Control
        0: Word clock is an input (slave mode)
        1: Word clock is an output (master mode)

Current code sets BIT_CLK_MASTER and WORD_CLK_MASTER bits for master mode,
but does not clear these bits for slave mode.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index a77f6ea..14cb553 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1021,6 +1021,7 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		aic3x->master = 0;
+		iface_areg &= ~(BIT_CLK_MASTER | WORD_CLK_MASTER);
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.5.4
