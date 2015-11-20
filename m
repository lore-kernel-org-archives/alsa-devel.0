From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: wm5102: Move driver to use
 SND_SOC_BYTES_TLV
Date: Fri, 20 Nov 2015 22:37:50 +0530
Message-ID: <20151120170750.GL25173@localhost>
References: <1447853952-6414-3-git-send-email-vinod.koul@intel.com>
 <201511182144.8dDI1Wfc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7612A264FFF
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 18:04:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201511182144.8dDI1Wfc%fengguang.wu@intel.com>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, patches@opensource.wolfsonmicro.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, kbuild-all@01.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2015 at 09:52:17PM +0800, kbuild test robot wrote:
> Hi Vinod,
> 
> [auto build test WARNING on: asoc/for-next]
> [also build test WARNING on: v4.4-rc1 next-20151118]
> 
> url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/ASoC-remove-SND_SOC_BYTES_EXT/20151118-214039
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: tile-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile 
> 
> All warnings (new ones prefixed by >>):

These are false warns as the dependent TLV kcontrol change was merged same
day by Mark, but not picked by bot for this build.

Similar note on HSW patch too

-- 
~Vinod

> 
> >> sound/soc/codecs/wm5102.c:959:1: warning: initialization from incompatible pointer type [enabled by default]
>    sound/soc/codecs/wm5102.c:959:1: warning: (near initialization for '(anonymous).get') [enabled by default]
> >> sound/soc/codecs/wm5102.c:959:1: warning: initialization from incompatible pointer type [enabled by default]
>    sound/soc/codecs/wm5102.c:959:1: warning: (near initialization for '(anonymous).put') [enabled by default]
> 
> vim +959 sound/soc/codecs/wm5102.c
> 
>    943	
>    944	SOC_SINGLE("DRE Low Level ABS", ARIZONA_DRE_CONTROL_3,
>    945		   ARIZONA_DRE_LOW_LEVEL_ABS_SHIFT, 15, 0),
>    946	
>    947	SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
>    948	SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
>    949	
>    950	SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
>    951		   ARIZONA_SPK1R_MUTE_SHIFT, 1, 1),
>    952	
>    953	SOC_SINGLE("Noise Gate Switch", ARIZONA_NOISE_GATE_CONTROL,
>    954		   ARIZONA_NGATE_ENA_SHIFT, 1, 0),
>    955	SOC_SINGLE_TLV("Noise Gate Threshold Volume", ARIZONA_NOISE_GATE_CONTROL,
>    956		       ARIZONA_NGATE_THR_SHIFT, 7, 1, ng_tlv),
>    957	SOC_ENUM("Noise Gate Hold", arizona_ng_hold),
>    958	
>  > 959	SND_SOC_BYTES_TLV("Output Compensation Coefficient", WM5102_OUT_COMP_SZ,
>    960			  wm5102_out_comp_coeff_get, wm5102_out_comp_coeff_put),
>    961	
>    962	SOC_SINGLE_EXT("Output Compensation Switch", 0, 0, 1, 0,
>    963		       wm5102_out_comp_switch_get, wm5102_out_comp_switch_put),
>    964	
>    965	WM5102_NG_SRC("HPOUT1L", ARIZONA_NOISE_GATE_SELECT_1L),
>    966	WM5102_NG_SRC("HPOUT1R", ARIZONA_NOISE_GATE_SELECT_1R),
>    967	WM5102_NG_SRC("HPOUT2L", ARIZONA_NOISE_GATE_SELECT_2L),
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
