From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 36/41]
 sound/soc/intel/skylake/skl-sst-cldma.c:141:1-3: ERROR: test of a
 variable/field address
Date: Sun, 22 Nov 2015 15:41:14 +0530
Message-ID: <20151122101114.GM25173@localhost>
References: <201511201702.ZnD2L1We%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 820A12605F0
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 11:07:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201511201702.ZnD2L1We%fengguang.wu@intel.com>
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

On Fri, Nov 20, 2015 at 05:59:04PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   314038e40a62c7cdfc07aad0fe14dcd4383bc34d
> commit: ae395937ab95b8c62806af6a17a6cdfe6086401e [36/41] ASoC: Intel: Skylake: Fix cleanup of dma buffer
> 
> 
> coccinelle warnings: (new ones prefixed by >>)
> 
> >> sound/soc/intel/skylake/skl-sst-cldma.c:141:1-3: ERROR: test of a variable/field address
>    sound/soc/intel/skylake/skl-sst-cldma.c:143:1-3: ERROR: test of a variable/field address

Yes these are field address so should not be checked, will send a fix

-- 
~Vinod
