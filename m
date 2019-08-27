From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/6] Small fixes
Date: Tue, 27 Aug 2019 09:58:38 -0500
Message-ID: <d7dae124-eaef-4cc7-50a9-ea66521775b4@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 8/27/19 9:17 AM, Amadeusz Sławiński wrote:
> Series of small fixes:
> * fixes few issues found during checking code with static checkers
> * fix few prints
> * define function in header, like it should be
> * release topology when done with it
> 
> Amadeusz Sławiński (6):
>    ASoC: Intel: Skylake: Use correct function to access iomem space
>    ASoC: Intel: Fix use of potentially uninitialized variable
>    ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
>    ASoC: Intel: Skylake: Print module type instead of id
>    ASoC: Intel: Skylake: Release topology when we are done with it
>    ASoC: Intel: NHLT: Fix debug print format

LGTM

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
>   include/sound/soc-dapm.h               |  3 +++
>   sound/soc/intel/common/sst-ipc.c       |  2 ++
>   sound/soc/intel/skylake/skl-debug.c    |  2 +-
>   sound/soc/intel/skylake/skl-messages.c |  5 +++--
>   sound/soc/intel/skylake/skl-nhlt.c     |  2 +-
>   sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
>   sound/soc/intel/skylake/skl.h          |  1 -
>   sound/soc/soc-topology.c               |  6 ------
>   8 files changed, 20 insertions(+), 21 deletions(-)
> 
