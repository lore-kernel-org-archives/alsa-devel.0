From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/tas2552 1/8]
 sound/soc/codecs/tas2552.c:493:27-28: Unneeded semicolon
Date: Fri, 5 Jun 2015 03:21:04 +0800
Message-ID: <201506050350.VWBQIwkL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F0E5F2606C8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 21:21:26 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/tas2552
head:   16bd395259cf3e9966d40478891e0e610da109d4
commit: ea178d1456dcf88875d5edd148f2df8ea0de1794 [1/8] ASoC: tas2552: Make the enable-gpio really optional


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tas2552.c:493:27-28: Unneeded semicolon

vim +493 sound/soc/codecs/tas2552.c

   477	{
   478		struct device *dev;
   479		struct tas2552_data *data;
   480		int ret;
   481		int i;
   482	
   483		dev = &client->dev;
   484		data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
   485		if (data == NULL)
   486			return -ENOMEM;
   487	
   488		data->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
   489		if (IS_ERR(data->enable_gpio)) {
   490			if (PTR_ERR(data->enable_gpio) == -EPROBE_DEFER)
   491				return -EPROBE_DEFER;
   492	
 > 493			data->enable_gpio = NULL;;
   494		}
   495	
   496		data->tas2552_client = client;
   497		data->regmap = devm_regmap_init_i2c(client, &tas2552_regmap_config);
   498		if (IS_ERR(data->regmap)) {
   499			ret = PTR_ERR(data->regmap);
   500			dev_err(&client->dev, "Failed to allocate register map: %d\n",
   501				ret);

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
