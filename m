From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Skylake - Add Skylake
 RT286 I2S machine driver
Date: Tue, 13 Oct 2015 20:34:00 +0800
Message-ID: <201510132011.QQhf4QV3%fengguang.wu@intel.com>
References: <1444729074-24184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FA08261AF6
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 14:34:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1444729074-24184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, kbuild-all@01.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Omair,

[auto build test WARNING on asoc/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/ASoC-Intel-Skylake-Add-Skylake-RT286-I2S-machine-driver/20151013-174125
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/boards/skl_rt286.c:121:37: sparse: incorrect type in argument 2 (different base types)
   sound/soc/intel/boards/skl_rt286.c:121:37:    expected unsigned int [unsigned] val
   sound/soc/intel/boards/skl_rt286.c:121:37:    got restricted snd_pcm_format_t [usertype] <noident>
--
>> sound/soc/intel/skylake/skl-pcm.c:167:56: sparse: incorrect type in argument 3 (different base types)
   sound/soc/intel/skylake/skl-pcm.c:167:56:    expected unsigned int [unsigned] format
   sound/soc/intel/skylake/skl-pcm.c:167:56:    got restricted snd_pcm_format_t [usertype] format
--
>> sound/soc/intel/skylake/skl-nhlt.c:117:41: sparse: cast removes address space of expression
--
>> sound/soc/intel/skylake/skl-topology.c:1187:47: sparse: incorrect type in argument 4 (different base types)
   sound/soc/intel/skylake/skl-topology.c:1187:47:    expected unsigned short [unsigned] [usertype] event_type
   sound/soc/intel/skylake/skl-topology.c:1187:47:    got restricted __le16 [usertype] event_type

vim +121 sound/soc/intel/boards/skl_rt286.c

   105	}
   106	
   107	
   108	static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
   109				struct snd_pcm_hw_params *params)
   110	{
   111		struct snd_interval *rate = hw_param_interval(params,
   112				SNDRV_PCM_HW_PARAM_RATE);
   113		struct snd_interval *channels = hw_param_interval(params,
   114							SNDRV_PCM_HW_PARAM_CHANNELS);
   115	
   116		/* The output is 48KHz, stereo, 16bits */
   117		rate->min = rate->max = 48000;
   118		channels->min = channels->max = 2;
   119		snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
   120					    SNDRV_PCM_HW_PARAM_FIRST_MASK],
 > 121					    SNDRV_PCM_FORMAT_S16_LE);
   122	
   123		return 0;
   124	}
   125	
   126	static int skylake_rt286_hw_params(struct snd_pcm_substream *substream,
   127		struct snd_pcm_hw_params *params)
   128	{
   129		struct snd_soc_pcm_runtime *rtd = substream->private_data;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
