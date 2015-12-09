From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 75/78]
 sound/soc/intel/boards/skl_rt286.c:55:2: error: implicit declaration of
 function 'SND_SOC_DAPM_SINK'
Date: Wed, 9 Dec 2015 21:42:30 +0530
Message-ID: <20151209161230.GF1854@localhost>
References: <201512090450.UOjjnJOi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6818D2614D0
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 17:11:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201512090450.UOjjnJOi%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2015 at 04:05:51AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   9ec2053b13f75d7ad9c0e6db9763954bd1a1b9ae
> commit: b34e24d2406f123d5dbbff4fdeebbc2af76b0acd [75/78] ASoC: Intel: Skylake: add wov as int sink
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         git checkout b34e24d2406f123d5dbbff4fdeebbc2af76b0acd
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> sound/soc/intel/boards/skl_rt286.c:55:2: error: implicit declaration of function 'SND_SOC_DAPM_SINK' [-Werror=implicit-function-declaration]
>      SND_SOC_DAPM_SINK("WoV Sink"),

This is false alarm. SND_SOC_DAPM_SINK is in mark's dapm branch I think

Thanks

>      ^
> >> sound/soc/intel/boards/skl_rt286.c:55:2: error: initializer element is not constant
>    sound/soc/intel/boards/skl_rt286.c:55:2: note: (near initialization for 'skylake_widgets[5].id')
> >> sound/soc/intel/boards/skl_rt286.c:49:61: warning: missing braces around initializer [-Wmissing-braces]
>     static const struct snd_soc_dapm_widget skylake_widgets[] = {
>                                                                 ^
>    sound/soc/intel/boards/skl_rt286.c:49:61: note: (near initialization for 'skylake_widgets')
>    cc1: some warnings being treated as errors
> 
> vim +/SND_SOC_DAPM_SINK +55 sound/soc/intel/boards/skl_rt286.c
> 
>     43	static const struct snd_kcontrol_new skylake_controls[] = {
>     44		SOC_DAPM_PIN_SWITCH("Speaker"),
>     45		SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>     46		SOC_DAPM_PIN_SWITCH("Mic Jack"),
>     47	};
>     48	
>   > 49	static const struct snd_soc_dapm_widget skylake_widgets[] = {
>     50		SND_SOC_DAPM_HP("Headphone Jack", NULL),
>     51		SND_SOC_DAPM_SPK("Speaker", NULL),
>     52		SND_SOC_DAPM_MIC("Mic Jack", NULL),
>     53		SND_SOC_DAPM_MIC("DMIC2", NULL),
>     54		SND_SOC_DAPM_MIC("SoC DMIC", NULL),
>   > 55		SND_SOC_DAPM_SINK("WoV Sink"),
>     56	};
>     57	
>     58	static const struct snd_soc_dapm_route skylake_rt286_map[] = {
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
~Vinod
