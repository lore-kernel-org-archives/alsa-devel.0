From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [asoc:for-4.19 199/204]
 sound/soc//meson/axg-tdm-interface.c:225:8: error: implicit declaration of
 function 'clk_set_duty_cycle'; did you mean 'clk_set_rate'?
Date: Fri, 20 Jul 2018 20:40:58 +0200
Message-ID: <1532112058.26720.62.camel@baylibre.com>
References: <201807210204.l9GJCtSI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E529267762
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 20:41:00 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so10306169wmh.2
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 11:41:00 -0700 (PDT)
In-Reply-To: <201807210204.l9GJCtSI%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2018-07-21 at 02:12 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.19
> head:   a8e43c21a8a32a3af4abc605b6ebcab039f28e00
> commit: c41c2a355b86368608377eaf3df442ec0f342f1e [199/204] ASoC: meson: add tdm output driver
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout c41c2a355b86368608377eaf3df442ec0f342f1e
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=m68k 
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc//meson/axg-tdm-interface.c: In function 'axg_tdm_iface_set_lrclk':
> > > sound/soc//meson/axg-tdm-interface.c:225:8: error: implicit declaration of function 'clk_set_duty_cycle'; did you mean 'clk_set_rate'? [-Werror=implicit-function-declaration]
> 
>      ret = clk_set_duty_cycle(iface->lrclk, ratio_num, 2);

Hi Mark,

I'm really sorry about this. I completely forgot this dependency.
It has been accepted in clk early in this cycle and it should be sent to Linus
during the next merge window. Mike and Stephen have topic branch with related
change:

git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-core-duty-cycle

commit:
9fba738a53dd ("clk: add duty cycle support") 

Again, sorry about this.
Regards
Jerome

>            ^~~~~~~~~~~~~~~~~~
>            clk_set_rate
>    cc1: some warnings being treated as errors
> 
> vim +225 sound/soc//meson/axg-tdm-interface.c
> 
> d60e4f1e Jerome Brunet 2018-07-17  188  
> d60e4f1e Jerome Brunet 2018-07-17  189  static int axg_tdm_iface_set_lrclk(struct snd_soc_dai *dai,
> d60e4f1e Jerome Brunet 2018-07-17  190  				   struct snd_pcm_hw_params *params)
> d60e4f1e Jerome Brunet 2018-07-17  191  {
> d60e4f1e Jerome Brunet 2018-07-17  192  	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
> d60e4f1e Jerome Brunet 2018-07-17  193  	unsigned int ratio_num;
> d60e4f1e Jerome Brunet 2018-07-17  194  	int ret;
> d60e4f1e Jerome Brunet 2018-07-17  195  
> d60e4f1e Jerome Brunet 2018-07-17  196  	ret = clk_set_rate(iface->lrclk, params_rate(params));
> d60e4f1e Jerome Brunet 2018-07-17  197  	if (ret) {
> d60e4f1e Jerome Brunet 2018-07-17  198  		dev_err(dai->dev, "setting sample clock failed: %d\n", ret);
> d60e4f1e Jerome Brunet 2018-07-17  199  		return ret;
> d60e4f1e Jerome Brunet 2018-07-17  200  	}
> d60e4f1e Jerome Brunet 2018-07-17  201  
> d60e4f1e Jerome Brunet 2018-07-17  202  	switch (iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> d60e4f1e Jerome Brunet 2018-07-17  203  	case SND_SOC_DAIFMT_I2S:
> d60e4f1e Jerome Brunet 2018-07-17  204  	case SND_SOC_DAIFMT_LEFT_J:
> d60e4f1e Jerome Brunet 2018-07-17  205  	case SND_SOC_DAIFMT_RIGHT_J:
> d60e4f1e Jerome Brunet 2018-07-17  206  		/* 50% duty cycle ratio */
> d60e4f1e Jerome Brunet 2018-07-17  207  		ratio_num = 1;
> d60e4f1e Jerome Brunet 2018-07-17  208  		break;
> d60e4f1e Jerome Brunet 2018-07-17  209  
> d60e4f1e Jerome Brunet 2018-07-17  210  	case SND_SOC_DAIFMT_DSP_A:
> d60e4f1e Jerome Brunet 2018-07-17  211  	case SND_SOC_DAIFMT_DSP_B:
> d60e4f1e Jerome Brunet 2018-07-17  212  		/*
> d60e4f1e Jerome Brunet 2018-07-17  213  		 * A zero duty cycle ratio will result in setting the mininum
> d60e4f1e Jerome Brunet 2018-07-17  214  		 * ratio possible which, for this clock, is 1 cycle of the
> d60e4f1e Jerome Brunet 2018-07-17  215  		 * parent bclk clock high and the rest low, This is exactly
> d60e4f1e Jerome Brunet 2018-07-17  216  		 * what we want here.
> d60e4f1e Jerome Brunet 2018-07-17  217  		 */
> d60e4f1e Jerome Brunet 2018-07-17  218  		ratio_num = 0;
> d60e4f1e Jerome Brunet 2018-07-17  219  		break;
> d60e4f1e Jerome Brunet 2018-07-17  220  
> d60e4f1e Jerome Brunet 2018-07-17  221  	default:
> d60e4f1e Jerome Brunet 2018-07-17  222  		return -EINVAL;
> d60e4f1e Jerome Brunet 2018-07-17  223  	}
> d60e4f1e Jerome Brunet 2018-07-17  224  
> d60e4f1e Jerome Brunet 2018-07-17 @225  	ret = clk_set_duty_cycle(iface->lrclk, ratio_num, 2);
> d60e4f1e Jerome Brunet 2018-07-17  226  	if (ret) {
> d60e4f1e Jerome Brunet 2018-07-17  227  		dev_err(dai->dev,
> d60e4f1e Jerome Brunet 2018-07-17  228  			"setting sample clock duty cycle failed: %d\n", ret);
> d60e4f1e Jerome Brunet 2018-07-17  229  		return ret;
> d60e4f1e Jerome Brunet 2018-07-17  230  	}
> d60e4f1e Jerome Brunet 2018-07-17  231  
> d60e4f1e Jerome Brunet 2018-07-17  232  	/* Set sample clock inversion */
> d60e4f1e Jerome Brunet 2018-07-17  233  	ret = clk_set_phase(iface->lrclk,
> d60e4f1e Jerome Brunet 2018-07-17  234  			    axg_tdm_lrclk_invert(iface->fmt) ? 180 : 0);
> d60e4f1e Jerome Brunet 2018-07-17  235  	if (ret) {
> d60e4f1e Jerome Brunet 2018-07-17  236  		dev_err(dai->dev,
> d60e4f1e Jerome Brunet 2018-07-17  237  			"setting sample clock phase failed: %d\n", ret);
> d60e4f1e Jerome Brunet 2018-07-17  238  		return ret;
> d60e4f1e Jerome Brunet 2018-07-17  239  	}
> d60e4f1e Jerome Brunet 2018-07-17  240  
> d60e4f1e Jerome Brunet 2018-07-17  241  	return 0;
> d60e4f1e Jerome Brunet 2018-07-17  242  }
> d60e4f1e Jerome Brunet 2018-07-17  243  
> 
> :::::: The code at line 225 was first introduced by commit
> :::::: d60e4f1e4be5e2dfb55fb084b119aed094227a35 ASoC: meson: add tdm interface driver
> 
> :::::: TO: Jerome Brunet <jbrunet@baylibre.com>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
