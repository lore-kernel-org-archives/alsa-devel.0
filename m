From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [asoc:topic/intel 24/43] undefined reference to
	`dw_dma_remove'
Date: Mon, 23 Nov 2015 13:01:20 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9229F0FB8@SHSMSX101.ccr.corp.intel.com>
References: <201511220944.4oAAlMmB%fengguang.wu@intel.com>
 <20151122105055.GO25173@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C22A265347
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 14:01:24 +0100 (CET)
In-Reply-To: <20151122105055.GO25173@localhost>
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
To: "Koul, Vinod" <vinod.koul@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Koul, Vinod
>Sent: Sunday, November 22, 2015 6:51 PM
>To: Wu, Fengguang; Jie, Yang
>Cc: kbuild-all@01.org; alsa-devel@alsa-project.org; Mark Brown
>Subject: Re: [asoc:topic/intel 24/43] undefined reference to
>`dw_dma_remove'
>
>On Sun, Nov 22, 2015 at 09:52:46AM +0800, kbuild test robot wrote:
>> tree:
>https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>topic/intel
>> head:   85af2a665144f40cdf60c0e0e7fe88e40c20b0fa
>> commit: 12cc291b0b58503b3b0e629ac605218df1851ce1 [24/43] ASoC:
>Intel: Atom: move atom driver to common acpi match
>> config: x86_64-randconfig-s5-11220851 (attached as .config)
>> reproduce:
>>         git checkout 12cc291b0b58503b3b0e629ac605218df1851ce1
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All errors (new ones prefixed by >>):
>>
>>    sound/built-in.o: In function `sst_dma_free':
>> >> (.text+0x3ee67): undefined reference to `dw_dma_remove'
>>    sound/built-in.o: In function `sst_dma_new':
>> >> (.text+0x4065e): undefined reference to `dw_dma_probe'
>
>Yes we do not use dw_dma as we use HDA DMA. The DW DMA is used in
>atom
>platforms. Keyon was planning to fix this up.
>
>Keyon did you get around to fix this and send patches

Yes, I did and submitted one, but it looks not thoroughly and not cover
this case(triggered by this new 'select SND_SOC_INTEL_SST' ), I will  
submit new patch to fix it.

Thanks,
~Keyon
