From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 24/43] undefined reference to
	`dw_dma_remove'
Date: Sun, 22 Nov 2015 16:20:56 +0530
Message-ID: <20151122105055.GO25173@localhost>
References: <201511220944.4oAAlMmB%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E7914260691
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 11:47:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201511220944.4oAAlMmB%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, "Jie, Yang" <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 22, 2015 at 09:52:46AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   85af2a665144f40cdf60c0e0e7fe88e40c20b0fa
> commit: 12cc291b0b58503b3b0e629ac605218df1851ce1 [24/43] ASoC: Intel: Atom: move atom driver to common acpi match
> config: x86_64-randconfig-s5-11220851 (attached as .config)
> reproduce:
>         git checkout 12cc291b0b58503b3b0e629ac605218df1851ce1
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    sound/built-in.o: In function `sst_dma_free':
> >> (.text+0x3ee67): undefined reference to `dw_dma_remove'
>    sound/built-in.o: In function `sst_dma_new':
> >> (.text+0x4065e): undefined reference to `dw_dma_probe'

Yes we do not use dw_dma as we use HDA DMA. The DW DMA is used in atom
platforms. Keyon was planning to fix this up.

Keyon did you get around to fix this and send patches

-- 
~Vinod
