From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] Drop owner assignment from i2c_driver (and
	platform left-overs)
Date: Fri, 10 Jul 2015 14:30:29 +0900
Message-ID: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 468AC2664F2
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 07:30:45 +0200 (CEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR9002E8BB62F30@mailout4.w1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 10 Jul 2015 06:30:42 +0100 (BST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  ASoC: Drop owner assignment from i2c_driver
  ASoC: Drop owner assignment from platform_driver

 sound/soc/codecs/adau1373.c               | 1 -
 sound/soc/codecs/adau1701.c               | 1 -
 sound/soc/codecs/adau1761-i2c.c           | 1 -
 sound/soc/codecs/adau1781-i2c.c           | 1 -
 sound/soc/codecs/adau1977-i2c.c           | 1 -
 sound/soc/codecs/adav803.c                | 1 -
 sound/soc/codecs/ak4535.c                 | 1 -
 sound/soc/codecs/ak4641.c                 | 1 -
 sound/soc/codecs/ak4642.c                 | 1 -
 sound/soc/codecs/ak4671.c                 | 1 -
 sound/soc/codecs/alc5623.c                | 1 -
 sound/soc/codecs/alc5632.c                | 1 -
 sound/soc/codecs/cs35l32.c                | 1 -
 sound/soc/codecs/cs4265.c                 | 1 -
 sound/soc/codecs/cs4270.c                 | 1 -
 sound/soc/codecs/cs4271-i2c.c             | 1 -
 sound/soc/codecs/cs42l51-i2c.c            | 1 -
 sound/soc/codecs/cs42l52.c                | 1 -
 sound/soc/codecs/cs42l56.c                | 1 -
 sound/soc/codecs/cs42l73.c                | 1 -
 sound/soc/codecs/cs42xx8-i2c.c            | 1 -
 sound/soc/codecs/da7210.c                 | 1 -
 sound/soc/codecs/da7213.c                 | 1 -
 sound/soc/codecs/da732x.c                 | 1 -
 sound/soc/codecs/da9055.c                 | 1 -
 sound/soc/codecs/isabelle.c               | 1 -
 sound/soc/codecs/lm4857.c                 | 1 -
 sound/soc/codecs/lm49453.c                | 1 -
 sound/soc/codecs/max9768.c                | 1 -
 sound/soc/codecs/max98088.c               | 1 -
 sound/soc/codecs/max98090.c               | 1 -
 sound/soc/codecs/max98095.c               | 1 -
 sound/soc/codecs/max9850.c                | 1 -
 sound/soc/codecs/max9877.c                | 1 -
 sound/soc/codecs/max98925.c               | 1 -
 sound/soc/codecs/ml26124.c                | 1 -
 sound/soc/codecs/pcm1681.c                | 1 -
 sound/soc/codecs/pcm512x-i2c.c            | 1 -
 sound/soc/codecs/rt286.c                  | 1 -
 sound/soc/codecs/rt5631.c                 | 1 -
 sound/soc/codecs/rt5640.c                 | 1 -
 sound/soc/codecs/rt5645.c                 | 1 -
 sound/soc/codecs/rt5651.c                 | 1 -
 sound/soc/codecs/rt5670.c                 | 1 -
 sound/soc/codecs/rt5677.c                 | 1 -
 sound/soc/codecs/sgtl5000.c               | 1 -
 sound/soc/codecs/ssm2518.c                | 1 -
 sound/soc/codecs/ssm2602-i2c.c            | 1 -
 sound/soc/codecs/ssm4567.c                | 1 -
 sound/soc/codecs/sta32x.c                 | 1 -
 sound/soc/codecs/sta350.c                 | 1 -
 sound/soc/codecs/sta529.c                 | 1 -
 sound/soc/codecs/tas2552.c                | 1 -
 sound/soc/codecs/tas5086.c                | 1 -
 sound/soc/codecs/tfa9879.c                | 1 -
 sound/soc/codecs/tlv320aic31xx.c          | 1 -
 sound/soc/codecs/tlv320aic32x4.c          | 1 -
 sound/soc/codecs/tlv320aic3x.c            | 1 -
 sound/soc/codecs/tlv320dac33.c            | 1 -
 sound/soc/codecs/tpa6130a2.c              | 1 -
 sound/soc/codecs/ts3a227e.c               | 1 -
 sound/soc/codecs/uda1380.c                | 1 -
 sound/soc/codecs/wm1250-ev1.c             | 1 -
 sound/soc/codecs/wm2000.c                 | 1 -
 sound/soc/codecs/wm2200.c                 | 1 -
 sound/soc/codecs/wm5100.c                 | 1 -
 sound/soc/codecs/wm8510.c                 | 1 -
 sound/soc/codecs/wm8523.c                 | 1 -
 sound/soc/codecs/wm8580.c                 | 1 -
 sound/soc/codecs/wm8711.c                 | 1 -
 sound/soc/codecs/wm8728.c                 | 1 -
 sound/soc/codecs/wm8731.c                 | 1 -
 sound/soc/codecs/wm8737.c                 | 1 -
 sound/soc/codecs/wm8741.c                 | 1 -
 sound/soc/codecs/wm8750.c                 | 1 -
 sound/soc/codecs/wm8753.c                 | 1 -
 sound/soc/codecs/wm8776.c                 | 1 -
 sound/soc/codecs/wm8804-i2c.c             | 1 -
 sound/soc/codecs/wm8900.c                 | 1 -
 sound/soc/codecs/wm8903.c                 | 1 -
 sound/soc/codecs/wm8904.c                 | 1 -
 sound/soc/codecs/wm8940.c                 | 1 -
 sound/soc/codecs/wm8955.c                 | 1 -
 sound/soc/codecs/wm8960.c                 | 1 -
 sound/soc/codecs/wm8961.c                 | 1 -
 sound/soc/codecs/wm8962.c                 | 1 -
 sound/soc/codecs/wm8971.c                 | 1 -
 sound/soc/codecs/wm8974.c                 | 1 -
 sound/soc/codecs/wm8978.c                 | 1 -
 sound/soc/codecs/wm8983.c                 | 1 -
 sound/soc/codecs/wm8985.c                 | 1 -
 sound/soc/codecs/wm8988.c                 | 1 -
 sound/soc/codecs/wm8990.c                 | 1 -
 sound/soc/codecs/wm8991.c                 | 1 -
 sound/soc/codecs/wm8993.c                 | 1 -
 sound/soc/codecs/wm8995.c                 | 1 -
 sound/soc/codecs/wm8996.c                 | 1 -
 sound/soc/codecs/wm9081.c                 | 1 -
 sound/soc/codecs/wm9090.c                 | 1 -
 sound/soc/mediatek/mt8173-max98090.c      | 1 -
 sound/soc/mediatek/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mtk-afe-pcm.c          | 1 -
 102 files changed, 102 deletions(-)

-- 
1.9.1
