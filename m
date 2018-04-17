From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-4.18 48/50]
 sound/soc/intel/skylake/skl-pcm.c:1372:37: sparse: incorrect type in
 argument 1 (different base types)
Date: Wed, 18 Apr 2018 04:08:27 +0800
Message-ID: <201804180425.I4fAMSo6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AD67D267650
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 22:08:54 +0200 (CEST)
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.18
head:   5db6aab6f36f7560dc95f7ca340d5632b7a3be6a
commit: 81e9b0a078894841a50a8dd666fd64ca452a2a50 [48/50] ASoC: topology: Give more data to clients via callbacks
reproduce:
        # apt-get install sparse
        git checkout 81e9b0a078894841a50a8dd666fd64ca452a2a50
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/intel/skylake/skl-pcm.c:159:43: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/soc/intel/skylake/skl-pcm.c:159:43:    expected unsigned int [unsigned] format
   sound/soc/intel/skylake/skl-pcm.c:159:43:    got restricted snd_pcm_format_t [usertype] format
   sound/soc/intel/skylake/skl-pcm.c:195:47: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/soc/intel/skylake/skl-pcm.c:195:47:    expected unsigned int [unsigned] format
   sound/soc/intel/skylake/skl-pcm.c:195:47:    got restricted snd_pcm_format_t [usertype] format
   sound/soc/intel/skylake/skl-pcm.c:1351:25: sparse: undefined identifier 'skl_tplg_add_moduleid_in_bind_params'
>> sound/soc/intel/skylake/skl-pcm.c:1372:37: sparse: incorrect type in argument 1 (different base types) @@    expected struct snd_soc_platform *platform @@    got sstruct snd_soc_platform *platform @@
   sound/soc/intel/skylake/skl-pcm.c:1372:37:    expected struct snd_soc_platform *platform
   sound/soc/intel/skylake/skl-pcm.c:1372:37:    got struct snd_soc_component *component
>> sound/soc/intel/skylake/skl-pcm.c:1351:61: sparse: call with no type!
   sound/soc/intel/skylake/skl-pcm.c: In function 'skl_populate_modules':
   sound/soc/intel/skylake/skl-pcm.c:1351:4: error: implicit declaration of function 'skl_tplg_add_moduleid_in_bind_params'; did you mean 'skl_tplg_update_pipe_params'? [-Werror=implicit-function-declaration]
       skl_tplg_add_moduleid_in_bind_params(skl, w);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       skl_tplg_update_pipe_params
   sound/soc/intel/skylake/skl-pcm.c: In function 'skl_platform_soc_probe':
   sound/soc/intel/skylake/skl-pcm.c:1372:23: error: passing argument 1 of 'skl_tplg_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ret = skl_tplg_init(component, ebus);
                          ^~~~~~~~~
   In file included from sound/soc/intel/skylake/skl-pcm.c:28:0:
   sound/soc/intel/skylake/skl-topology.h:463:5: note: expected 'struct snd_soc_platform *' but argument is of type 'struct snd_soc_component *'
    int skl_tplg_init(struct snd_soc_platform *platform,
        ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +1372 sound/soc/intel/skylake/skl-pcm.c

b26199ea Jeeja KP          2017-03-24  1330  
64cb1d0a Vinod Koul        2016-08-10  1331  static int skl_populate_modules(struct skl *skl)
64cb1d0a Vinod Koul        2016-08-10  1332  {
64cb1d0a Vinod Koul        2016-08-10  1333  	struct skl_pipeline *p;
64cb1d0a Vinod Koul        2016-08-10  1334  	struct skl_pipe_module *m;
64cb1d0a Vinod Koul        2016-08-10  1335  	struct snd_soc_dapm_widget *w;
64cb1d0a Vinod Koul        2016-08-10  1336  	struct skl_module_cfg *mconfig;
b26199ea Jeeja KP          2017-03-24  1337  	int ret = 0;
64cb1d0a Vinod Koul        2016-08-10  1338  
64cb1d0a Vinod Koul        2016-08-10  1339  	list_for_each_entry(p, &skl->ppl_list, node) {
64cb1d0a Vinod Koul        2016-08-10  1340  		list_for_each_entry(m, &p->pipe->w_list, node) {
64cb1d0a Vinod Koul        2016-08-10  1341  			w = m->w;
64cb1d0a Vinod Koul        2016-08-10  1342  			mconfig = w->priv;
64cb1d0a Vinod Koul        2016-08-10  1343  
b26199ea Jeeja KP          2017-03-24  1344  			ret = skl_get_module_info(skl, mconfig);
64cb1d0a Vinod Koul        2016-08-10  1345  			if (ret < 0) {
64cb1d0a Vinod Koul        2016-08-10  1346  				dev_err(skl->skl_sst->dev,
b26199ea Jeeja KP          2017-03-24  1347  					"query module info failed\n");
b26199ea Jeeja KP          2017-03-24  1348  				return ret;
64cb1d0a Vinod Koul        2016-08-10  1349  			}
f7a9f772 Sriram Periyasamy 2018-01-27  1350  
f7a9f772 Sriram Periyasamy 2018-01-27 @1351  			skl_tplg_add_moduleid_in_bind_params(skl, w);
64cb1d0a Vinod Koul        2016-08-10  1352  		}
64cb1d0a Vinod Koul        2016-08-10  1353  	}
b26199ea Jeeja KP          2017-03-24  1354  
64cb1d0a Vinod Koul        2016-08-10  1355  	return ret;
64cb1d0a Vinod Koul        2016-08-10  1356  }
64cb1d0a Vinod Koul        2016-08-10  1357  
56b03b4c Kuninori Morimoto 2018-01-29  1358  static int skl_platform_soc_probe(struct snd_soc_component *component)
b663a8c5 Jeeja KP          2015-10-07  1359  {
56b03b4c Kuninori Morimoto 2018-01-29  1360  	struct hdac_ext_bus *ebus = dev_get_drvdata(component->dev);
fe3f4442 Dharageswari R    2016-06-03  1361  	struct skl *skl = ebus_to_skl(ebus);
78cdbbda Vinod Koul        2016-07-26  1362  	const struct skl_dsp_ops *ops;
fe3f4442 Dharageswari R    2016-06-03  1363  	int ret;
b663a8c5 Jeeja KP          2015-10-07  1364  
56b03b4c Kuninori Morimoto 2018-01-29  1365  	pm_runtime_get_sync(component->dev);
ec8ae570 Vinod Koul        2016-08-04  1366  	if ((ebus_to_hbus(ebus))->ppcap) {
56b03b4c Kuninori Morimoto 2018-01-29  1367  		skl->component = component;
5cdf6c09 Vinod Koul        2017-06-30  1368  
5cdf6c09 Vinod Koul        2017-06-30  1369  		/* init debugfs */
5cdf6c09 Vinod Koul        2017-06-30  1370  		skl->debugfs = skl_debugfs_init(skl);
5cdf6c09 Vinod Koul        2017-06-30  1371  
56b03b4c Kuninori Morimoto 2018-01-29 @1372  		ret = skl_tplg_init(component, ebus);
fe3f4442 Dharageswari R    2016-06-03  1373  		if (ret < 0) {
56b03b4c Kuninori Morimoto 2018-01-29  1374  			dev_err(component->dev, "Failed to init topology!\n");
fe3f4442 Dharageswari R    2016-06-03  1375  			return ret;
fe3f4442 Dharageswari R    2016-06-03  1376  		}
78cdbbda Vinod Koul        2016-07-26  1377  
78cdbbda Vinod Koul        2016-07-26  1378  		/* load the firmwares, since all is set */
78cdbbda Vinod Koul        2016-07-26  1379  		ops = skl_get_dsp_ops(skl->pci->device);
78cdbbda Vinod Koul        2016-07-26  1380  		if (!ops)
78cdbbda Vinod Koul        2016-07-26  1381  			return -EIO;
78cdbbda Vinod Koul        2016-07-26  1382  
78cdbbda Vinod Koul        2016-07-26  1383  		if (skl->skl_sst->is_first_boot == false) {
56b03b4c Kuninori Morimoto 2018-01-29  1384  			dev_err(component->dev, "DSP reports first boot done!!!\n");
78cdbbda Vinod Koul        2016-07-26  1385  			return -EIO;
78cdbbda Vinod Koul        2016-07-26  1386  		}
78cdbbda Vinod Koul        2016-07-26  1387  
fc9fdd61 Sanyog Kale       2018-03-13  1388  		/*
fc9fdd61 Sanyog Kale       2018-03-13  1389  		 * Disable dynamic clock and power gating during firmware
fc9fdd61 Sanyog Kale       2018-03-13  1390  		 * and library download
fc9fdd61 Sanyog Kale       2018-03-13  1391  		 */
56b03b4c Kuninori Morimoto 2018-01-29  1392  		skl->skl_sst->enable_miscbdcge(component->dev, false);
fc9fdd61 Sanyog Kale       2018-03-13  1393  		skl->skl_sst->clock_power_gating(component->dev, false);
d5cc0a1f Pardha Saradhi K  2018-01-02  1394  
56b03b4c Kuninori Morimoto 2018-01-29  1395  		ret = ops->init_fw(component->dev, skl->skl_sst);
56b03b4c Kuninori Morimoto 2018-01-29  1396  		skl->skl_sst->enable_miscbdcge(component->dev, true);
fc9fdd61 Sanyog Kale       2018-03-13  1397  		skl->skl_sst->clock_power_gating(component->dev, true);
78cdbbda Vinod Koul        2016-07-26  1398  		if (ret < 0) {
56b03b4c Kuninori Morimoto 2018-01-29  1399  			dev_err(component->dev, "Failed to boot first fw: %d\n", ret);
78cdbbda Vinod Koul        2016-07-26  1400  			return ret;
78cdbbda Vinod Koul        2016-07-26  1401  		}
64cb1d0a Vinod Koul        2016-08-10  1402  		skl_populate_modules(skl);
a26a3f53 Pardha Saradhi K  2016-11-03  1403  		skl->skl_sst->update_d0i3c = skl_update_d0i3c;
cb729d80 G Kranthi         2017-03-13  1404  		skl_dsp_enable_notification(skl->skl_sst, false);
9452314d Pradeep Tewani    2017-12-06  1405  
9452314d Pradeep Tewani    2017-12-06  1406  		if (skl->cfg.astate_cfg != NULL) {
9452314d Pradeep Tewani    2017-12-06  1407  			skl_dsp_set_astate_cfg(skl->skl_sst,
9452314d Pradeep Tewani    2017-12-06  1408  					skl->cfg.astate_cfg->count,
9452314d Pradeep Tewani    2017-12-06  1409  					skl->cfg.astate_cfg);
9452314d Pradeep Tewani    2017-12-06  1410  		}
fe3f4442 Dharageswari R    2016-06-03  1411  	}
56b03b4c Kuninori Morimoto 2018-01-29  1412  	pm_runtime_mark_last_busy(component->dev);
56b03b4c Kuninori Morimoto 2018-01-29  1413  	pm_runtime_put_autosuspend(component->dev);
b663a8c5 Jeeja KP          2015-10-07  1414  
b663a8c5 Jeeja KP          2015-10-07  1415  	return 0;
b663a8c5 Jeeja KP          2015-10-07  1416  }
56b03b4c Kuninori Morimoto 2018-01-29  1417  

:::::: The code at line 1372 was first introduced by commit
:::::: 56b03b4c4f5e8e1a44328b2df75bfb31fc4c3609 ASoC: intel: skylake: replace platform to component

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
