From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [asoc:topic/intel 38/38]
 sound/soc/intel/common/sst-firmware.c:1278:20: error: expected declaration
 specifiers or '...' before string constant
Date: Sun, 22 Oct 2017 15:25:00 +0530
Message-ID: <60faca99-948d-6087-f909-538c1e5fccee@linux.intel.com>
References: <201710211936.sIx11hK3%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C90F0266DE2
 for <alsa-devel@alsa-project.org>; Sun, 22 Oct 2017 11:55:00 +0200 (CEST)
In-Reply-To: <201710211936.sIx11hK3%fengguang.wu@intel.com>
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
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Not sure what happened here, the code was posted on an internal mailing 
list which is supposed to be checked by the 0-day infrastructure 
precisely to avoid this sort of issues before going upstream...

Anyways, there is obviously a missing dependency on X86, this code can't 
possibly work on extensa or s390.


On 10/21/17 4:38 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   f6a118a800e35af2c63f90cbcc23093f4b53b3a2
> commit: f6a118a800e35af2c63f90cbcc23093f4b53b3a2 [38/38] ASoC: Intel: clarify Kconfig dependencies
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 4.9.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout f6a118a800e35af2c63f90cbcc23093f4b53b3a2
>          # save the attached .config to linux build tree
>          make.cross ARCH=xtensa
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/soc/intel/common/sst-firmware.c:1278:20: error: expected declaration specifiers or '...' before string constant
>      MODULE_DESCRIPTION("Intel SST Firmware Loader");
>                         ^
>     sound/soc/intel/common/sst-firmware.c:1279:16: error: expected declaration specifiers or '...' before string constant
>      MODULE_LICENSE("GPL v2");
>                     ^
> --
>     sound/soc/intel/haswell/sst-haswell-pcm.c: In function 'create_adsp_page_table':
>>> sound/soc/intel/haswell/sst-haswell-pcm.c:446:2: error: implicit declaration of function 'snd_sgbuf_aligned_pages' [-Werror=implicit-function-declaration]
>       pages = snd_sgbuf_aligned_pages(size);
>       ^
>     cc1: some warnings being treated as errors
> 
> vim +1278 sound/soc/intel/common/sst-firmware.c
> 
> a395bdd6 Takashi Iwai 2016-07-11  1277
> a395bdd6 Takashi Iwai 2016-07-11 @1278  MODULE_DESCRIPTION("Intel SST Firmware Loader");
> 
> :::::: The code at line 1278 was first introduced by commit
> :::::: a395bdd6b24b692adbce0df6510ec9f2af57573e ASoC: intel: Fix sst-dsp dependency on dw stuff
> 
> :::::: TO: Takashi Iwai <tiwai@suse.de>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
