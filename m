From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [asoc:for-5.2 248/316] ld:
 sound/soc/sof/sof-acpi-dev.o:undefined reference to `sof_xtensa_arch_ops'
Date: Tue, 7 May 2019 10:22:37 -0500
Message-ID: <476de058-ef89-101b-850d-dbc6aa716d9c@linux.intel.com>
References: <201905071715.qMuQoKTo%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1DF1F89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 18:12:47 +0200 (CEST)
In-Reply-To: <201905071715.qMuQoKTo%lkp@intel.com>
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
To: kbuild test robot <lkp@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org



On 5/7/19 4:20 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
> head:   f153bf49ddf6169544b24ef5ea26fa3eb4996b95
> commit: 7e978fa37df7f771a5d02934ff828a0ee36bcf11 [248/316] ASoC: SOF: Add Build support for SOF core and Intel drivers
> config: i386-randconfig-l0-05071509 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>          git checkout 7e978fa37df7f771a5d02934ff828a0ee36bcf11
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x120): undefined reference to `sof_xtensa_arch_ops'
>     ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x180): undefined reference to `sof_xtensa_arch_ops'
>     ld: sound/soc/sof/sof-acpi-dev.o:(.rodata+0x1e0): undefined reference to `sof_xtensa_arch_ops'

Ack. this is due to a stupid typo in a Kconfig, will send a formal fix 
shortly.

  config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
         tristate
-       select SND_SOC_INTEL_COMMON
+       select SND_SOC_SOF_INTEL_COMMON


No idea why it wasn't found earlier, kbuild tracks the SOF tree but 
never complained about this one...

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
