From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [asoc:topic/max9867 2/4]
 sound/soc/codecs/max9867.c:294:11: error: 'component' undeclared;
 did you mean 'complete'?
Date: Thu, 1 Mar 2018 21:01:56 +0100
Message-ID: <20180301200155.GA2304@lenoch>
References: <201803020314.sOjeazAH%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E2621267BA9
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:02:11 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992827AbeCAUCI6jjzL (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 21:02:08 +0100
Content-Disposition: inline
In-Reply-To: <201803020314.sOjeazAH%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Mark,

On Fri, Mar 02, 2018 at 03:45:16AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/max9867
> head:   79e139744508105bd749300f364563934bff23f2
> commit: 8b9c716aada77e72e2fe82320aba5a95b75ca400 [2/4] ASoC: max9867: Improve error logging
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 8b9c716aada77e72e2fe82320aba5a95b75ca400
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc/codecs/max9867.c: In function 'max9867_set_dai_sysclk':
> >> sound/soc/codecs/max9867.c:294:11: error: 'component' undeclared (first use in this function); did you mean 'complete'?
>       dev_err(component->dev,
>               ^~~~~~~~~
>               complete
>    sound/soc/codecs/max9867.c:294:11: note: each undeclared identifier is reported only once for each function it appears in

your topic/max9867 seems to be 4.16-rc1 based, while patch was tested
in today's -next. Fixing it for 4.16-rc1 would mean it fails to compile
once you merge topic branches.

What am I supposed to do here?

Thank you,
	ladis

> vim +294 sound/soc/codecs/max9867.c
> 
>    275	
>    276	static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>    277			int clk_id, unsigned int freq, int dir)
>    278	{
>    279		struct snd_soc_codec *codec = codec_dai->codec;
>    280		struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
>    281		int value = 0;
>    282	
>    283		/* Set the prescaler based on the master clock frequency*/
>    284		if (freq >= 10000000 && freq <= 20000000) {
>    285			value |= MAX9867_PSCLK_10_20;
>    286			max9867->pclk =  freq;
>    287		} else if (freq >= 20000000 && freq <= 40000000) {
>    288			value |= MAX9867_PSCLK_20_40;
>    289			max9867->pclk =  freq/2;
>    290		} else if (freq >= 40000000 && freq <= 60000000) {
>    291			value |= MAX9867_PSCLK_40_60;
>    292			max9867->pclk =  freq/4;
>    293		} else {
>  > 294			dev_err(component->dev,
>    295				"Invalid clock frequency %uHz (required 10-60MHz)\n",
>    296				freq);
>    297			return -EINVAL;
>    298		}
>    299		value = value << MAX9867_PSCLK_SHIFT;
>    300		max9867->sysclk = freq;
>    301		/* exact integer mode is not supported */
>    302		value &= ~MAX9867_FREQ_MASK;
>    303		regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
>    304				MAX9867_PSCLK_MASK, value);
>    305		return 0;
>    306	}
>    307	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
