From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] ASoC: es7241: add es7241 codec support
Date: Sat, 30 Jun 2018 11:28:29 +0300
Message-ID: <20180630082829.qwnhkk4f76n32omm@mwanda>
References: <20180629152444.21525-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <20180629152444.21525-3-jbrunet@baylibre.com>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Hi Jerome,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc2 next-20180629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ASoC-add-es7241-support/20180630-021159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

smatch warnings:
sound/soc/codecs/es7241.c:147 es7241_set_fmt() warn: missing break? reassigning 'priv->is_slave'

# https://github.com/0day-ci/linux/commit/d494a70ae50e5f95d2ab09bcaf3065b4359bde0e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d494a70ae50e5f95d2ab09bcaf3065b4359bde0e
vim +147 sound/soc/codecs/es7241.c

d494a70a Jerome Brunet 2018-06-29  123  
d494a70a Jerome Brunet 2018-06-29  124  static int es7241_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
d494a70a Jerome Brunet 2018-06-29  125  {
d494a70a Jerome Brunet 2018-06-29  126  	struct es7241_data *priv = snd_soc_dai_get_drvdata(dai);
d494a70a Jerome Brunet 2018-06-29  127  
d494a70a Jerome Brunet 2018-06-29  128  	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
d494a70a Jerome Brunet 2018-06-29  129  		dev_err(dai->dev, "Unsupported dai clock inversion\n");
d494a70a Jerome Brunet 2018-06-29  130  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  131  	}
d494a70a Jerome Brunet 2018-06-29  132  
d494a70a Jerome Brunet 2018-06-29  133  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
d494a70a Jerome Brunet 2018-06-29  134  	case SND_SOC_DAIFMT_I2S:
d494a70a Jerome Brunet 2018-06-29  135  	case SND_SOC_DAIFMT_LEFT_J:
d494a70a Jerome Brunet 2018-06-29  136  		break;
d494a70a Jerome Brunet 2018-06-29  137  
d494a70a Jerome Brunet 2018-06-29  138  	default:
d494a70a Jerome Brunet 2018-06-29  139  		dev_err(dai->dev, "Unsupported dai format\n");
d494a70a Jerome Brunet 2018-06-29  140  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  141  	}
d494a70a Jerome Brunet 2018-06-29  142  
d494a70a Jerome Brunet 2018-06-29  143  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
d494a70a Jerome Brunet 2018-06-29  144  	case SND_SOC_DAIFMT_CBS_CFS:
d494a70a Jerome Brunet 2018-06-29  145  		priv->is_slave = true;
d494a70a Jerome Brunet 2018-06-29  146  	case SND_SOC_DAIFMT_CBM_CFM:
d494a70a Jerome Brunet 2018-06-29 @147  		priv->is_slave = false;
d494a70a Jerome Brunet 2018-06-29  148  		break;
d494a70a Jerome Brunet 2018-06-29  149  
d494a70a Jerome Brunet 2018-06-29  150  	default:
d494a70a Jerome Brunet 2018-06-29  151  		dev_err(dai->dev, "Unsupported clock configuration\n");
d494a70a Jerome Brunet 2018-06-29  152  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  153  	}
d494a70a Jerome Brunet 2018-06-29  154  
d494a70a Jerome Brunet 2018-06-29  155  	return 0;
d494a70a Jerome Brunet 2018-06-29  156  }
d494a70a Jerome Brunet 2018-06-29  157  
