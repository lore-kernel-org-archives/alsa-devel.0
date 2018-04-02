From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 2/8] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Mon, 2 Apr 2018 07:15:25 +0530
Message-ID: <1061924c-53b4-13dd-aea8-1f968d76f947@amd.com>
References: <1522069983-11381-3-git-send-email-Vijendar.Mukunda@amd.com>
 <201803281957.UsRRgO6F%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0064.outbound.protection.outlook.com [104.47.36.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 63BF826735C
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 03:43:04 +0200 (CEST)
In-Reply-To: <201803281957.UsRRgO6F%fengguang.wu@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, kbuild-all@01.org, Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org



On Wednesday 28 March 2018 04:53 PM, kbuild test robot wrote:
> Hi Vijendar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on asoc/for-next]
> [also build test ERROR on next-20180327]
> [cannot apply to v4.16-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vijendar-Mukunda/ASoC-dwc-I2S-Controller-instance-param-added/20180327-175125
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: x86_64-randconfig-s1-03281558 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>     sound/soc/dwc/dwc-i2s.o: In function `dw_pcm_push_tx':
>>> sound/soc/dwc/dwc-i2s.c:721: multiple definition of `dw_pcm_push_tx'
>     sound/soc/amd/acp-pcm-dma.o:sound/soc/amd/acp-pcm-dma.c:933: first defined here
>     sound/soc/dwc/dwc-i2s.o: In function `dw_pcm_pop_rx':
>>> sound/soc/dwc/local.h:129: multiple definition of `dw_pcm_pop_rx'
>     sound/soc/amd/acp-pcm-dma.o:sound/soc/amd/../dwc/local.h:129: first defined here
>     sound/soc/dwc/dwc-i2s.o: In function `dw_pcm_register':
>>> sound/soc/dwc/local.h:131: multiple definition of `dw_pcm_register'
>     sound/soc/amd/acp-pcm-dma.o:sound/soc/amd/../dwc/local.h:131: first defined here
> 
> vim +129 sound/soc/dwc/local.h
> 
> 79361b2b Jose Abreu 2016-06-09  122
> 79361b2b Jose Abreu 2016-06-09  123  #if IS_ENABLED(CONFIG_SND_DESIGNWARE_PCM)
> 79361b2b Jose Abreu 2016-06-09  124  void dw_pcm_push_tx(struct dw_i2s_dev *dev);
> e2f748e0 Jose Abreu 2016-12-27  125  void dw_pcm_pop_rx(struct dw_i2s_dev *dev);
> 79361b2b Jose Abreu 2016-06-09  126  int dw_pcm_register(struct platform_device *pdev);
> 79361b2b Jose Abreu 2016-06-09  127  #else
> 79361b2b Jose Abreu 2016-06-09  128  void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
> e2f748e0 Jose Abreu 2016-12-27 @129  void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
> 79361b2b Jose Abreu 2016-06-09  130  int dw_pcm_register(struct platform_device *pdev)
> 79361b2b Jose Abreu 2016-06-09 @131  {
> 79361b2b Jose Abreu 2016-06-09  132  	return -EINVAL;
> 79361b2b Jose Abreu 2016-06-09  133  }
> 79361b2b Jose Abreu 2016-06-09  134  #endif
> 79361b2b Jose Abreu 2016-06-09  135
> 
> :::::: The code at line 129 was first introduced by commit
> :::::: e2f748e06db389d9fd51413df23ff8d3615a47db ASoC: dwc: Add record capability in PIO mode
> 
> :::::: TO: Jose Abreu <Jose.Abreu@synopsys.com>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

posted patch as V2 after fixing kbuild errors.

Below is the link.

https://patchwork.kernel.org/patch/10316177/
