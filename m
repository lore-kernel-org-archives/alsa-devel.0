From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/rt5616 2/2]
 sound/soc/codecs/rt5665.c:4590:3-9: preceding lock on line 4553
Date: Tue, 15 Nov 2016 10:04:09 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1611151002350.3153@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id B27C926661C
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 10:04:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

It looks from the code like a mutex_unlock may be needed on line 4590.
There is a warning about the same issue with respect to like 4609,
although that is not shown.

julia


---------- Forwarded message ----------
Date: Tue, 15 Nov 2016 08:39:41 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/rt5616 2/2] sound/soc/codecs/rt5665.c:4590:3-9: preceding
    lock on line 4553

CC: kbuild-all@01.org
CC: alsa-devel@alsa-project.org
TO: Bard Liao <bardliao@realtek.com>
CC: Mark Brown <broonie@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/rt5616
head:   33ada14a26c8f174dac8765f4236ca66c64ae5be
commit: 33ada14a26c8f174dac8765f4236ca66c64ae5be [2/2] ASoC: add rt5665 codec driver
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago

>> sound/soc/codecs/rt5665.c:4590:3-9: preceding lock on line 4553
>> sound/soc/codecs/rt5665.c:4590:3-9: preceding lock on line 4553
   sound/soc/codecs/rt5665.c:4609:3-9: preceding lock on line 4553

git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout 33ada14a26c8f174dac8765f4236ca66c64ae5be
vim +4590 sound/soc/codecs/rt5665.c

33ada14a Bard Liao 2016-11-14  4547  }
33ada14a Bard Liao 2016-11-14  4548
33ada14a Bard Liao 2016-11-14  4549  static void rt5665_calibrate(struct rt5665_priv *rt5665)
33ada14a Bard Liao 2016-11-14  4550  {
33ada14a Bard Liao 2016-11-14  4551  	int value, count;
33ada14a Bard Liao 2016-11-14  4552
33ada14a Bard Liao 2016-11-14 @4553  	mutex_lock(&rt5665->calibrate_mutex);
33ada14a Bard Liao 2016-11-14  4554
33ada14a Bard Liao 2016-11-14  4555  	regcache_cache_bypass(rt5665->regmap, true);
33ada14a Bard Liao 2016-11-14  4556
33ada14a Bard Liao 2016-11-14  4557  	regmap_write(rt5665->regmap, RT5665_RESET, 0);
33ada14a Bard Liao 2016-11-14  4558  	regmap_write(rt5665->regmap, RT5665_BIAS_CUR_CTRL_8, 0xa602);
33ada14a Bard Liao 2016-11-14  4559  	regmap_write(rt5665->regmap, RT5665_HP_CHARGE_PUMP_1, 0x0c26);
33ada14a Bard Liao 2016-11-14  4560  	regmap_write(rt5665->regmap, RT5665_MONOMIX_IN_GAIN, 0x021f);
33ada14a Bard Liao 2016-11-14  4561  	regmap_write(rt5665->regmap, RT5665_MONO_OUT, 0x480a);
33ada14a Bard Liao 2016-11-14  4562  	regmap_write(rt5665->regmap, RT5665_PWR_MIXER, 0x083f);
33ada14a Bard Liao 2016-11-14  4563  	regmap_write(rt5665->regmap, RT5665_PWR_DIG_1, 0x0180);
33ada14a Bard Liao 2016-11-14  4564  	regmap_write(rt5665->regmap, RT5665_EJD_CTRL_1, 0x4040);
33ada14a Bard Liao 2016-11-14  4565  	regmap_write(rt5665->regmap, RT5665_HP_LOGIC_CTRL_2, 0x0000);
33ada14a Bard Liao 2016-11-14  4566  	regmap_write(rt5665->regmap, RT5665_DIG_MISC, 0x0001);
33ada14a Bard Liao 2016-11-14  4567  	regmap_write(rt5665->regmap, RT5665_MICBIAS_2, 0x0380);
33ada14a Bard Liao 2016-11-14  4568  	regmap_write(rt5665->regmap, RT5665_GLB_CLK, 0x8000);
33ada14a Bard Liao 2016-11-14  4569  	regmap_write(rt5665->regmap, RT5665_ADDA_CLK_1, 0x1000);
33ada14a Bard Liao 2016-11-14  4570  	regmap_write(rt5665->regmap, RT5665_CHOP_DAC, 0x3030);
33ada14a Bard Liao 2016-11-14  4571  	regmap_write(rt5665->regmap, RT5665_CALIB_ADC_CTRL, 0x3c05);
33ada14a Bard Liao 2016-11-14  4572  	regmap_write(rt5665->regmap, RT5665_PWR_ANLG_1, 0xaa3e);
33ada14a Bard Liao 2016-11-14  4573  	usleep_range(15000, 20000);
33ada14a Bard Liao 2016-11-14  4574  	regmap_write(rt5665->regmap, RT5665_PWR_ANLG_1, 0xfe7e);
33ada14a Bard Liao 2016-11-14  4575  	regmap_write(rt5665->regmap, RT5665_HP_CALIB_CTRL_2, 0x0321);
33ada14a Bard Liao 2016-11-14  4576
33ada14a Bard Liao 2016-11-14  4577  	regmap_write(rt5665->regmap, RT5665_HP_CALIB_CTRL_1, 0xfc00);
33ada14a Bard Liao 2016-11-14  4578  	count = 0;
33ada14a Bard Liao 2016-11-14  4579  	while (true) {
33ada14a Bard Liao 2016-11-14  4580  		regmap_read(rt5665->regmap, RT5665_HP_CALIB_STA_1, &value);
33ada14a Bard Liao 2016-11-14  4581  		if (value & 0x8000)
33ada14a Bard Liao 2016-11-14  4582  			usleep_range(10000, 10005);
33ada14a Bard Liao 2016-11-14  4583  		else
33ada14a Bard Liao 2016-11-14  4584  			break;
33ada14a Bard Liao 2016-11-14  4585
33ada14a Bard Liao 2016-11-14  4586  		if (count > 60) {
33ada14a Bard Liao 2016-11-14  4587  			pr_err("HP Calibration Failure\n");
33ada14a Bard Liao 2016-11-14  4588  			regmap_write(rt5665->regmap, RT5665_RESET, 0);
33ada14a Bard Liao 2016-11-14  4589  			regcache_cache_bypass(rt5665->regmap, false);
33ada14a Bard Liao 2016-11-14 @4590  			return;
33ada14a Bard Liao 2016-11-14  4591  		}
33ada14a Bard Liao 2016-11-14  4592
33ada14a Bard Liao 2016-11-14  4593  		count++;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
