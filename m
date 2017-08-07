From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 15/17] ASoC: cs47l35: Add codec driver
 for Cirrus Logic CS47L35
Date: Mon, 7 Aug 2017 09:32:19 +0100
Message-ID: <1502094739.5479.21.camel@rf-debian.wolfsonmicro.main>
References: <201707300644.LqBZNeVM%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C1CF4267046
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 10:32:24 +0200 (CEST)
In-Reply-To: <201707300644.LqBZNeVM%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, broonie@kernel.org, lee.jones@linaro.org
Cc: linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2017-07-30 at 07:01 +0800, kbuild test robot wrote:
> Hi Richard,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.13-rc2 next-20170728]
> [cannot apply to ljones-mfd/for-mfd-next asoc/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Richard-Fitzgerald/Add-support-for-Cirrus-Logic-CS47L35-L85-L90-L91-codecs/20170730-062737
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: the linux-review/Richard-Fitzgerald/Add-support-for-Cirrus-Logic-CS47L35-L85-L90-L91-codecs/20170730-062737 HEAD 15487144eec6910ecfbbbbd97bb5a2c7efdb259f builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
> >> sound/soc//codecs/madera.c:146:2: error: 'MADERA_IRQ_DSP1_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP1_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:147:2: error: 'MADERA_IRQ_DSP2_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP2_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:148:2: error: 'MADERA_IRQ_DSP3_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP3_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:149:2: error: 'MADERA_IRQ_DSP4_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP4_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:150:2: error: 'MADERA_IRQ_DSP5_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP5_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:151:2: error: 'MADERA_IRQ_DSP6_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP6_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc//codecs/madera.c:152:2: error: 'MADERA_IRQ_DSP7_BUS_ERROR' undeclared here (not in a function)
>      MADERA_IRQ_DSP7_BUS_ERROR,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> 

Oops. The rename of these somehow got merged into the top patch instead
of going into #14 where it should be. I'll wait a while and see what
comments I get on the earlier patches, maybe they will all be accepted
for merge and then I'll only have to reissue the top 4 patches to fix
this.

> vim +/MADERA_IRQ_DSP1_BUS_ERROR +146 sound/soc//codecs/madera.c
> 
> da1efc4cc Richard Fitzgerald 2017-07-28  130  
> da1efc4cc Richard Fitzgerald 2017-07-28  131  #define madera_fll_err(_fll, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  132  	dev_err(_fll->madera->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  133  #define madera_fll_warn(_fll, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  134  	dev_warn(_fll->madera->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  135  #define madera_fll_dbg(_fll, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  136  	dev_dbg(_fll->madera->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  137  
> da1efc4cc Richard Fitzgerald 2017-07-28  138  #define madera_aif_err(_dai, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  139  	dev_err(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  140  #define madera_aif_warn(_dai, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  141  	dev_warn(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  142  #define madera_aif_dbg(_dai, fmt, ...) \
> da1efc4cc Richard Fitzgerald 2017-07-28  143  	dev_dbg(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
> da1efc4cc Richard Fitzgerald 2017-07-28  144  
> da1efc4cc Richard Fitzgerald 2017-07-28  145  static const int madera_dsp_bus_error_irqs[MADERA_MAX_ADSP] = {
> da1efc4cc Richard Fitzgerald 2017-07-28 @146  	MADERA_IRQ_DSP1_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @147  	MADERA_IRQ_DSP2_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @148  	MADERA_IRQ_DSP3_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @149  	MADERA_IRQ_DSP4_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @150  	MADERA_IRQ_DSP5_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @151  	MADERA_IRQ_DSP6_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28 @152  	MADERA_IRQ_DSP7_BUS_ERROR,
> da1efc4cc Richard Fitzgerald 2017-07-28  153  };
> da1efc4cc Richard Fitzgerald 2017-07-28  154  
> 
> :::::: The code at line 146 was first introduced by commit
> :::::: da1efc4cc715281f9599274bb5ff408b19cd3335 ASoC: madera: Add common support for Cirrus Logic Madera codecs
> 
> :::::: TO: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
