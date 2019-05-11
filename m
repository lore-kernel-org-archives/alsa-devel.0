From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 0/2] ASoC: Intel: Add Cometlake PCI IDs
Date: Sat, 11 May 2019 13:17:01 -0500
Message-ID: <3cd20987-c251-f068-271a-546a83f27188@linux.intel.com>
References: <20190510223929.165569-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510223929.165569-1-evgreen@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/10/19 5:39 PM, Evan Green wrote:
> 
> This small series adds PCI IDs for Cometlake platforms, for a
> dazzling audio experience.
> 
> This is based on linux-next's next-20190510.

Thank you Evan, looks good. For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Changes in v3:
> - Copy cnl_desc to new cml_desc, and avoid selecting cannonlake (Pierre-Louis)
> - Don't select CML_* in SND_SOC_INTEL_SKYLAKE (Pierre-Louis)
> 
> Changes in v2:
> - Add CML-H ID 0x06c8 (Pierre-Louis)
> - Add 0x06c8 for CML-H (Pierre-Louis)
> 
> Evan Green (2):
>    ASoC: SOF: Add Comet Lake PCI IDs
>    ASoC: Intel: Skylake: Add Cometlake PCI IDs
> 
>   sound/soc/intel/Kconfig                | 16 +++++++++++++
>   sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++
>   sound/soc/intel/skylake/skl.c          | 10 ++++++++
>   sound/soc/sof/intel/Kconfig            | 32 ++++++++++++++++++++++++++
>   sound/soc/sof/sof-pci-dev.c            | 28 ++++++++++++++++++++++
>   5 files changed, 102 insertions(+)
> 
