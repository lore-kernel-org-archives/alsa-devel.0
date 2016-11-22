From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/samsung 15/16]
 sound/soc/samsung/i2s.c:1270:2-4: ERROR: test of a variable/field address
Date: Wed, 23 Nov 2016 05:15:55 +0800
Message-ID: <201611230552.0zGwYYZm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 35D3C2667B2
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 22:16:23 +0100 (CET)
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/samsung
head:   95f5609d223d661419061bd6231da01a317c30d9
commit: a41dcdeee5d87cf3852b857cc3a8507832ec8b42 [15/16] ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/samsung/i2s.c:1270:2-4: ERROR: test of a variable/field address

vim +1270 sound/soc/samsung/i2s.c

40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1254  		return -ENOMEM;
1c7ac018 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  1255  	}
1c7ac018 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  1256  
f3670536 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  1257  	spin_lock_init(&pri_dai->spinlock);
f3670536 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  1258  	pri_dai->lock = &pri_dai->spinlock;
f3670536 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  1259  
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1260  	if (!np) {
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1261  		if (i2s_pdata == NULL) {
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1262  			dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1263  			return -EINVAL;
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1264  		}
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1265  
69e7a69a sound/soc/samsung/i2s.c Sylwester Nawrocki 2016-08-04  1266  		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
69e7a69a sound/soc/samsung/i2s.c Sylwester Nawrocki 2016-08-04  1267  		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
9bdca822 sound/soc/samsung/i2s.c Arnd Bergmann      2015-11-18  1268  		pri_dai->filter = i2s_pdata->dma_filter;
b9a1a743 sound/soc/samsung/i2s.c Arnd Bergmann      2015-11-18  1269  
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18 @1270  		if (&i2s_pdata->type)
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1271  			i2s_cfg = &i2s_pdata->type.i2s;
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1272  
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1273  		if (i2s_cfg) {
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1274  			quirks = i2s_cfg->quirks;
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1275  			idma_addr = i2s_cfg->idma_addr;
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1276  		}
40476f61 sound/soc/samsung/i2s.c Padmavathi Venna   2013-01-18  1277  	} else {
7da493e9 sound/soc/samsung/i2s.c Padmavathi Venna   2013-08-12  1278  		quirks = i2s_dai_data->quirks;

:::::: The code at line 1270 was first introduced by commit
:::::: 40476f61897933d524b7069a6df65629a469d922 ASoC: samsung: Add DT support for i2s

:::::: TO: Padmavathi Venna <padma.v@samsung.com>
:::::: CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
