From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: Haswell: Adjust machine
	device private
Date: Thu, 29 Aug 2019 17:45:50 -0500
Message-ID: <95d05cf3-b409-6c03-2419-4634586e21dc@linux.intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 335D7F800E7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:45:53 +0200 (CEST)
In-Reply-To: <20190822113616.22702-1-cezary.rojewski@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 8/22/19 6:36 AM, Cezary Rojewski wrote:
> Apart from Haswell machines, all other devices have their private data
> set to snd_soc_acpi_mach instance.
> 
> Changes for HSW/ BDW boards introduced with series:
> https://patchwork.kernel.org/cover/10782035/
> 
> added support for dai_link platform_name adjustments within card probe
> routines. These take for granted private_data points to
> snd_soc_acpi_mach whereas for Haswell, it's sst_pdata instead. Change
> private context of platform_device - representing machine board - to
> address this.
> 
> Caught by recent cleanups where content of sst_pdata was moved.
> Currently, despite the incorrect cast, dereferenced field points happily
> to NULL (uninitialized field), so no panics were observed.

No issues seen on Broadwell w/ rt5677 (Samus) so

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I think the two broadwell/bdw-rt5677 cases are the only ones used in 
products, I am not aware of anyone using the haswell machine driver.

Sorry for being thick with the review, I couldn't figure out from the 
patch itself how the code worked and what this DRV_NAME represented. 
It's definitively legit when looking at the entire tree, but I 
discovered that the 'DRV_NAME' is defined 3 times, see below. It's just 
lunacy to use the same define with different strings in different Intel 
drivers, we should clean this up with a prefix to avoid ambiguities.

atom/sst-mfld-platform.h:#define DRV_NAME "sst"
baytrail/sst-baytrail-pcm.c:#define DRV_NAME "byt-dai"
haswell/sst-haswell-ipc.h:#define DRV_NAME "haswell-dai"

> 
> Cezary Rojewski (4):
>    ASoC: Intel: Haswell: Adjust machine device private context
>    ASoC: Intel: haswell: Simplify device probe
>    ASoC: Intel: bdw-rt5677: Simplify device probe
>    ASoC: Intel: broadwell: Simplify device probe
> 
>   sound/soc/intel/boards/bdw-rt5677.c | 6 +-----
>   sound/soc/intel/boards/broadwell.c  | 6 +-----
>   sound/soc/intel/boards/haswell.c    | 6 +-----
>   sound/soc/intel/common/sst-acpi.c   | 3 ++-
>   4 files changed, 5 insertions(+), 16 deletions(-)
> 
