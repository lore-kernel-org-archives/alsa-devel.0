From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [asoc:for-5.1 329/329] sound/soc/soc-pcm.c:659
 soc_pcm_open() warn: inconsistent returns 'mutex:&rtd->pcm_mutex'.
Date: Mon, 8 Apr 2019 21:29:35 +0300
Message-ID: <20190408182935.GI6070@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAD19F89610
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 20:29:57 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kbuild@01.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1
head:   52034add758e268c39110f33d46e2a9492e82aef
commit: 52034add758e268c39110f33d46e2a9492e82aef [329/329] ASoC: pcm: update module refcount if module_get_upon_open is set

smatch warnings:
sound/soc/soc-pcm.c:659 soc_pcm_open() warn: inconsistent returns 'mutex:&rtd->pcm_mutex'.
  Locked on:   line 522
  Unlocked on: line 622

# https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=52034add758e268c39110f33d46e2a9492e82aef
git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout 52034add758e268c39110f33d46e2a9492e82aef
vim +659 sound/soc/soc-pcm.c

244e2936 Charles Keepax     2018-06-19  474  
58ba9b25 Mark Brown         2012-01-16  475  /*
ddee627c Liam Girdwood      2011-06-09  476   * Called by ALSA when a PCM substream is opened, the runtime->hw record is
ddee627c Liam Girdwood      2011-06-09  477   * then initialized and any private data can be allocated. This also calls
ef050bec Charles Keepax     2018-04-24  478   * startup for the cpu DAI, component, machine and codec DAI.
ddee627c Liam Girdwood      2011-06-09  479   */
ddee627c Liam Girdwood      2011-06-09  480  static int soc_pcm_open(struct snd_pcm_substream *substream)
ddee627c Liam Girdwood      2011-06-09  481  {
ddee627c Liam Girdwood      2011-06-09  482  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
ddee627c Liam Girdwood      2011-06-09  483  	struct snd_pcm_runtime *runtime = substream->runtime;
90be711e Kuninori Morimoto  2017-08-08  484  	struct snd_soc_component *component;
90be711e Kuninori Morimoto  2017-08-08  485  	struct snd_soc_rtdcom_list *rtdcom;
ddee627c Liam Girdwood      2011-06-09  486  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
2e5894d7 Benoit Cousson     2014-07-08  487  	struct snd_soc_dai *codec_dai;
2e5894d7 Benoit Cousson     2014-07-08  488  	const char *codec_dai_name = "multicodec";
244e2936 Charles Keepax     2018-06-19  489  	int i, ret = 0;
ddee627c Liam Girdwood      2011-06-09  490  
988e8cc4 Nicolin Chen       2013-11-04  491  	pinctrl_pm_select_default_state(cpu_dai->dev);
0b7990e3 Kuninori Morimoto  2018-09-03  492  	for_each_rtd_codec_dai(rtd, i, codec_dai)
0b7990e3 Kuninori Morimoto  2018-09-03  493  		pinctrl_pm_select_default_state(codec_dai->dev);
90be711e Kuninori Morimoto  2017-08-08  494  
90be711e Kuninori Morimoto  2017-08-08  495  	for_each_rtdcom(rtd, rtdcom) {
90be711e Kuninori Morimoto  2017-08-08  496  		component = rtdcom->component;
90be711e Kuninori Morimoto  2017-08-08  497  
90be711e Kuninori Morimoto  2017-08-08  498  		pm_runtime_get_sync(component->dev);
90be711e Kuninori Morimoto  2017-08-08  499  	}
d6652ef8 Mark Brown         2011-12-03  500  
b8c0dab9 Liam Girdwood      2011-06-09  501  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
                                                                  ^^^^^^^^^^^^^^^

ddee627c Liam Girdwood      2011-06-09  502  
ddee627c Liam Girdwood      2011-06-09  503  	/* startup the audio subsystem */
9900a422 Kuninori Morimoto  2017-09-25  504  	if (cpu_dai->driver->ops->startup) {
ddee627c Liam Girdwood      2011-06-09  505  		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
ddee627c Liam Girdwood      2011-06-09  506  		if (ret < 0) {
103d84a3 Liam Girdwood      2012-11-19  507  			dev_err(cpu_dai->dev, "ASoC: can't open interface"
103d84a3 Liam Girdwood      2012-11-19  508  				" %s: %d\n", cpu_dai->name, ret);
ddee627c Liam Girdwood      2011-06-09  509  			goto out;
                                                                ^^^^^^^^^

ddee627c Liam Girdwood      2011-06-09  510  		}
ddee627c Liam Girdwood      2011-06-09  511  	}
ddee627c Liam Girdwood      2011-06-09  512  
b8135864 Kuninori Morimoto  2017-10-11  513  	for_each_rtdcom(rtd, rtdcom) {
b8135864 Kuninori Morimoto  2017-10-11  514  		component = rtdcom->component;
b8135864 Kuninori Morimoto  2017-10-11  515  
b8135864 Kuninori Morimoto  2017-10-11  516  		if (!component->driver->ops ||
b8135864 Kuninori Morimoto  2017-10-11  517  		    !component->driver->ops->open)
b8135864 Kuninori Morimoto  2017-10-11  518  			continue;
b8135864 Kuninori Morimoto  2017-10-11  519  
52034add Ranjani Sridharan  2019-04-05  520  		if (component->driver->module_get_upon_open &&
52034add Ranjani Sridharan  2019-04-05  521  		    !try_module_get(component->dev->driver->owner))
52034add Ranjani Sridharan  2019-04-05  522  			return -ENODEV;
                                                                ^^^^^^^^^^^^^^^
We need some error handling before returning.

52034add Ranjani Sridharan  2019-04-05  523  
244e2936 Charles Keepax     2018-06-19  524  		ret = component->driver->ops->open(substream);
244e2936 Charles Keepax     2018-06-19  525  		if (ret < 0) {
b8135864 Kuninori Morimoto  2017-10-11  526  			dev_err(component->dev,
b8135864 Kuninori Morimoto  2017-10-11  527  				"ASoC: can't open component %s: %d\n",
244e2936 Charles Keepax     2018-06-19  528  				component->name, ret);
244e2936 Charles Keepax     2018-06-19  529  			goto component_err;
b8135864 Kuninori Morimoto  2017-10-11  530  		}
b8135864 Kuninori Morimoto  2017-10-11  531  	}
244e2936 Charles Keepax     2018-06-19  532  	component = NULL;
b8135864 Kuninori Morimoto  2017-10-11  533  
0b7990e3 Kuninori Morimoto  2018-09-03  534  	for_each_rtd_codec_dai(rtd, i, codec_dai) {
9900a422 Kuninori Morimoto  2017-09-25  535  		if (codec_dai->driver->ops->startup) {
2e5894d7 Benoit Cousson     2014-07-08  536  			ret = codec_dai->driver->ops->startup(substream,
2e5894d7 Benoit Cousson     2014-07-08  537  							      codec_dai);
ddee627c Liam Girdwood      2011-06-09  538  			if (ret < 0) {
2e5894d7 Benoit Cousson     2014-07-08  539  				dev_err(codec_dai->dev,
2e5894d7 Benoit Cousson     2014-07-08  540  					"ASoC: can't open codec %s: %d\n",
2e5894d7 Benoit Cousson     2014-07-08  541  					codec_dai->name, ret);
ddee627c Liam Girdwood      2011-06-09  542  				goto codec_dai_err;
ddee627c Liam Girdwood      2011-06-09  543  			}
ddee627c Liam Girdwood      2011-06-09  544  		}
ddee627c Liam Girdwood      2011-06-09  545  
2e5894d7 Benoit Cousson     2014-07-08  546  		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
2e5894d7 Benoit Cousson     2014-07-08  547  			codec_dai->tx_mask = 0;
2e5894d7 Benoit Cousson     2014-07-08  548  		else
2e5894d7 Benoit Cousson     2014-07-08  549  			codec_dai->rx_mask = 0;
2e5894d7 Benoit Cousson     2014-07-08  550  	}
2e5894d7 Benoit Cousson     2014-07-08  551  
75ab9eb6 Kuninori Morimoto  2017-09-26  552  	if (rtd->dai_link->ops->startup) {
ddee627c Liam Girdwood      2011-06-09  553  		ret = rtd->dai_link->ops->startup(substream);
ddee627c Liam Girdwood      2011-06-09  554  		if (ret < 0) {
103d84a3 Liam Girdwood      2012-11-19  555  			pr_err("ASoC: %s startup failed: %d\n",
25bfe662 Mark Brown         2012-02-01  556  			       rtd->dai_link->name, ret);
ddee627c Liam Girdwood      2011-06-09  557  			goto machine_err;
ddee627c Liam Girdwood      2011-06-09  558  		}
ddee627c Liam Girdwood      2011-06-09  559  	}
ddee627c Liam Girdwood      2011-06-09  560  
01d7584c Liam Girdwood      2012-04-25  561  	/* Dynamic PCM DAI links compat checks use dynamic capabilities */
01d7584c Liam Girdwood      2012-04-25  562  	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm)
01d7584c Liam Girdwood      2012-04-25  563  		goto dynamic;
01d7584c Liam Girdwood      2012-04-25  564  
ddee627c Liam Girdwood      2011-06-09  565  	/* Check that the codec and cpu DAIs are compatible */
2e5894d7 Benoit Cousson     2014-07-08  566  	soc_pcm_init_runtime_hw(substream);
2e5894d7 Benoit Cousson     2014-07-08  567  
2e5894d7 Benoit Cousson     2014-07-08  568  	if (rtd->num_codecs == 1)
2e5894d7 Benoit Cousson     2014-07-08  569  		codec_dai_name = rtd->codec_dai->name;
ddee627c Liam Girdwood      2011-06-09  570  
62e5f676 Lars-Peter Clausen 2013-11-30  571  	if (soc_pcm_has_symmetry(substream))
62e5f676 Lars-Peter Clausen 2013-11-30  572  		runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
62e5f676 Lars-Peter Clausen 2013-11-30  573  
ddee627c Liam Girdwood      2011-06-09  574  	ret = -EINVAL;
ddee627c Liam Girdwood      2011-06-09  575  	if (!runtime->hw.rates) {
103d84a3 Liam Girdwood      2012-11-19  576  		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
2e5894d7 Benoit Cousson     2014-07-08  577  			codec_dai_name, cpu_dai->name);
ddee627c Liam Girdwood      2011-06-09  578  		goto config_err;
ddee627c Liam Girdwood      2011-06-09  579  	}
ddee627c Liam Girdwood      2011-06-09  580  	if (!runtime->hw.formats) {
103d84a3 Liam Girdwood      2012-11-19  581  		printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
2e5894d7 Benoit Cousson     2014-07-08  582  			codec_dai_name, cpu_dai->name);
ddee627c Liam Girdwood      2011-06-09  583  		goto config_err;
ddee627c Liam Girdwood      2011-06-09  584  	}
ddee627c Liam Girdwood      2011-06-09  585  	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
ddee627c Liam Girdwood      2011-06-09  586  	    runtime->hw.channels_min > runtime->hw.channels_max) {
103d84a3 Liam Girdwood      2012-11-19  587  		printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
2e5894d7 Benoit Cousson     2014-07-08  588  				codec_dai_name, cpu_dai->name);
ddee627c Liam Girdwood      2011-06-09  589  		goto config_err;
ddee627c Liam Girdwood      2011-06-09  590  	}
ddee627c Liam Girdwood      2011-06-09  591  
c8dd1fec Benoit Cousson     2014-07-01  592  	soc_pcm_apply_msb(substream);
58ba9b25 Mark Brown         2012-01-16  593  
ddee627c Liam Girdwood      2011-06-09  594  	/* Symmetry only applies if we've already got an active stream. */
17841020 Dong Aisheng       2011-08-29  595  	if (cpu_dai->active) {
17841020 Dong Aisheng       2011-08-29  596  		ret = soc_pcm_apply_symmetry(substream, cpu_dai);
17841020 Dong Aisheng       2011-08-29  597  		if (ret != 0)
17841020 Dong Aisheng       2011-08-29  598  			goto config_err;
17841020 Dong Aisheng       2011-08-29  599  	}
17841020 Dong Aisheng       2011-08-29  600  
0b7990e3 Kuninori Morimoto  2018-09-03  601  	for_each_rtd_codec_dai(rtd, i, codec_dai) {
0b7990e3 Kuninori Morimoto  2018-09-03  602  		if (codec_dai->active) {
0b7990e3 Kuninori Morimoto  2018-09-03  603  			ret = soc_pcm_apply_symmetry(substream, codec_dai);
ddee627c Liam Girdwood      2011-06-09  604  			if (ret != 0)
ddee627c Liam Girdwood      2011-06-09  605  				goto config_err;
ddee627c Liam Girdwood      2011-06-09  606  		}
2e5894d7 Benoit Cousson     2014-07-08  607  	}
ddee627c Liam Girdwood      2011-06-09  608  
103d84a3 Liam Girdwood      2012-11-19  609  	pr_debug("ASoC: %s <-> %s info:\n",
2e5894d7 Benoit Cousson     2014-07-08  610  			codec_dai_name, cpu_dai->name);
103d84a3 Liam Girdwood      2012-11-19  611  	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
103d84a3 Liam Girdwood      2012-11-19  612  	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
ddee627c Liam Girdwood      2011-06-09  613  		 runtime->hw.channels_max);
103d84a3 Liam Girdwood      2012-11-19  614  	pr_debug("ASoC: min rate %d max rate %d\n", runtime->hw.rate_min,
ddee627c Liam Girdwood      2011-06-09  615  		 runtime->hw.rate_max);
ddee627c Liam Girdwood      2011-06-09  616  
01d7584c Liam Girdwood      2012-04-25  617  dynamic:
24894b76 Lars-Peter Clausen 2014-03-05  618  
24894b76 Lars-Peter Clausen 2014-03-05  619  	snd_soc_runtime_activate(rtd, substream->stream);
24894b76 Lars-Peter Clausen 2014-03-05  620  
b8c0dab9 Liam Girdwood      2011-06-09  621  	mutex_unlock(&rtd->pcm_mutex);
ddee627c Liam Girdwood      2011-06-09  622  	return 0;
ddee627c Liam Girdwood      2011-06-09  623  
ddee627c Liam Girdwood      2011-06-09  624  config_err:
75ab9eb6 Kuninori Morimoto  2017-09-26  625  	if (rtd->dai_link->ops->shutdown)
ddee627c Liam Girdwood      2011-06-09  626  		rtd->dai_link->ops->shutdown(substream);
ddee627c Liam Girdwood      2011-06-09  627  
ddee627c Liam Girdwood      2011-06-09  628  machine_err:
2e5894d7 Benoit Cousson     2014-07-08  629  	i = rtd->num_codecs;
2e5894d7 Benoit Cousson     2014-07-08  630  
2e5894d7 Benoit Cousson     2014-07-08  631  codec_dai_err:
6d11b128 Kuninori Morimoto  2018-09-18  632  	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
ddee627c Liam Girdwood      2011-06-09  633  		if (codec_dai->driver->ops->shutdown)
ddee627c Liam Girdwood      2011-06-09  634  			codec_dai->driver->ops->shutdown(substream, codec_dai);
2e5894d7 Benoit Cousson     2014-07-08  635  	}
ddee627c Liam Girdwood      2011-06-09  636  
b8135864 Kuninori Morimoto  2017-10-11  637  component_err:
244e2936 Charles Keepax     2018-06-19  638  	soc_pcm_components_close(substream, component);
b8135864 Kuninori Morimoto  2017-10-11  639  
ddee627c Liam Girdwood      2011-06-09  640  	if (cpu_dai->driver->ops->shutdown)
ddee627c Liam Girdwood      2011-06-09  641  		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
ddee627c Liam Girdwood      2011-06-09  642  out:
b8c0dab9 Liam Girdwood      2011-06-09  643  	mutex_unlock(&rtd->pcm_mutex);
d6652ef8 Mark Brown         2011-12-03  644  
90be711e Kuninori Morimoto  2017-08-08  645  	for_each_rtdcom(rtd, rtdcom) {
90be711e Kuninori Morimoto  2017-08-08  646  		component = rtdcom->component;
90be711e Kuninori Morimoto  2017-08-08  647  
90be711e Kuninori Morimoto  2017-08-08  648  		pm_runtime_mark_last_busy(component->dev);
90be711e Kuninori Morimoto  2017-08-08  649  		pm_runtime_put_autosuspend(component->dev);
3f809783 Sanyog Kale        2016-01-05  650  	}
3f809783 Sanyog Kale        2016-01-05  651  
0b7990e3 Kuninori Morimoto  2018-09-03  652  	for_each_rtd_codec_dai(rtd, i, codec_dai) {
0b7990e3 Kuninori Morimoto  2018-09-03  653  		if (!codec_dai->active)
0b7990e3 Kuninori Morimoto  2018-09-03  654  			pinctrl_pm_select_sleep_state(codec_dai->dev);
2e5894d7 Benoit Cousson     2014-07-08  655  	}
988e8cc4 Nicolin Chen       2013-11-04  656  	if (!cpu_dai->active)
988e8cc4 Nicolin Chen       2013-11-04  657  		pinctrl_pm_select_sleep_state(cpu_dai->dev);
d6652ef8 Mark Brown         2011-12-03  658  
ddee627c Liam Girdwood      2011-06-09 @659  	return ret;
ddee627c Liam Girdwood      2011-06-09  660  }
ddee627c Liam Girdwood      2011-06-09  661  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
