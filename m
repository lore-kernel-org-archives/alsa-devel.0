From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/3] ASoC: topology: Able to create BE DAIs
Date: Mon, 25 Jul 2016 01:58:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA8827E@shsmsx102.ccr.corp.intel.com>
References: <001ecaeba478e2ef863a232c89412b09d4b6de11.1469165422.git.mengdong.lin@linux.intel.com>
 <20160722124744.GD32690@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AB3265837
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2016 03:58:08 +0200 (CEST)
In-Reply-To: <20160722124744.GD32690@wfg-t540p.sh.intel.com>
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
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mengdong Lin <mengdong.lin@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>
List-Id: alsa-devel@alsa-project.org

Sorry for the mistake. I'll fix this warning.

Thanks
Mengdong

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Friday, July 22, 2016 8:48 PM
> To: mengdong.lin@linux.intel.com
> Cc: kbuild-all@01.org; alsa-devel@alsa-project.org; broonie@kernel.org;
> Mengdong Lin; tiwai@suse.de; Shah, Hardik T; Singh, Guneshwor O;
> liam.r.girdwood@linux.intel.com; Lin, Mengdong
> Subject: Re: [PATCH 3/3] ASoC: topology: Able to create BE DAIs
> 
> Hi Mengdong,
> 
> [auto build test WARNING on asoc/for-next] [also build test WARNING on
> v4.7-rc7]
> 
> url:
> https://github.com/0day-ci/linux/commits/mengdong-lin-linux-intel-com/AS
> oC-topology-Add-support-for-BE-DAIs/20160722-160125
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> for-next
> config: x86_64-randconfig-s0-07221711 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> 
>     sound/soc/soc-topology.c: In function 'soc_tplg_be_dai_config':
> >> sound/soc/soc-topology.c:1790: warning: too many arguments for
> format
>     At top level:
>     cc1: warning: unrecognized command line option
> "-Wno-maybe-uninitialized"
> 
> git remote add linux-review https://github.com/0day-ci/linux git remote
> update linux-review git checkout
> 234d57f817caf65062dd97dcd7e44be8f5e721e3
> vim +1790 sound/soc/soc-topology.c
> 
> 234d57f8 Mengdong Lin 2016-07-22  1774   * soc_tplg_be_dai_config -
> Create a new BE DAI or configure an existing one.
> 234d57f8 Mengdong Lin 2016-07-22  1775   * @tplg: topology context
> 234d57f8 Mengdong Lin 2016-07-22  1776   * @be: topology BE DAI
> configs.
> 234d57f8 Mengdong Lin 2016-07-22  1777   *
> 234d57f8 Mengdong Lin 2016-07-22  1778   * The BE dai should already
> be registered by the platform driver. The
> 234d57f8 Mengdong Lin 2016-07-22  1779   * platform driver should
> specify the BE DAI name and ID for matching.
> 234d57f8 Mengdong Lin 2016-07-22  1780   */
> 234d57f8 Mengdong Lin 2016-07-22  1781  static int
> soc_tplg_be_dai_config(struct soc_tplg *tplg,
> 234d57f8 Mengdong Lin 2016-07-22  1782  				  struct
> snd_soc_tplg_be_dai *be)
> 234d57f8 Mengdong Lin 2016-07-22  1783  {
> 234d57f8 Mengdong Lin 2016-07-22  1784  	struct
> snd_soc_dai_link_component dai_component = {0};
> 234d57f8 Mengdong Lin 2016-07-22  1785  	struct snd_soc_dai *dai;
> 234d57f8 Mengdong Lin 2016-07-22  1786  	struct snd_soc_dai_driver
> *dai_drv;
> 234d57f8 Mengdong Lin 2016-07-22  1787
> 234d57f8 Mengdong Lin 2016-07-22  1788  	if (!strlen(be->dai_name)) {
> 234d57f8 Mengdong Lin 2016-07-22  1789  		dev_err(tplg->dev,
> "ASoC: Invalid BE DAI name\n",
> 234d57f8 Mengdong Lin 2016-07-22 @1790  			be->dai_name);
> 234d57f8 Mengdong Lin 2016-07-22  1791  		return -EINVAL;
> 234d57f8 Mengdong Lin 2016-07-22  1792  	}
> 234d57f8 Mengdong Lin 2016-07-22  1793
> 234d57f8 Mengdong Lin 2016-07-22  1794  	dai_component.dai_name =
> be->dai_name;
> 234d57f8 Mengdong Lin 2016-07-22  1795  	dai =
> snd_soc_find_dai(&dai_component);
> 234d57f8 Mengdong Lin 2016-07-22  1796  	if (!dai) /* BE DAI doesn't
> exist, create it */
> 234d57f8 Mengdong Lin 2016-07-22  1797  		return
> soc_tplg_be_dai_create(tplg, be);
> 234d57f8 Mengdong Lin 2016-07-22  1798
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
