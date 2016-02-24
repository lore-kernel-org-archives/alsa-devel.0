From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [asoc:topic/intel 16/22]
 sound/soc/intel/boards/skl_rt286.c:29:36: fatal error:
 ../../codecs/hdac_hdmi.h: No such file or directory
Date: Wed, 24 Feb 2016 15:20:57 +0530
Message-ID: <20160224095056.GM17690@localhost>
References: <201602241754.oX4cPbIT%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AEFB2607F7
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 10:47:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201602241754.oX4cPbIT%fengguang.wu@intel.com>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 24, 2016 at 05:32:56PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   8be3838af0e992846d4725fae152b818560c1068
> commit: 23905cd1ca48cbc852a670a3dbbfc5e7d694580f [16/22] ASoC: Intel: boards: Enable HDMI and DP on skl_rt286 machine
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         git checkout 23905cd1ca48cbc852a670a3dbbfc5e7d694580f
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> sound/soc/intel/boards/skl_rt286.c:29:36: fatal error: ../../codecs/hdac_hdmi.h: No such file or directory
>    compilation terminated.

That is a false postive, the header is in mark's hdac topic branch, so next
does not have this failure.

Mark should we ignore this or you merge hdac into intel branch :)

> 
> vim +29 sound/soc/intel/boards/skl_rt286.c
> 
>     23	#include <sound/core.h>
>     24	#include <sound/pcm.h>
>     25	#include <sound/soc.h>
>     26	#include <sound/jack.h>
>     27	#include <sound/pcm_params.h>
>     28	#include "../../codecs/rt286.h"
>   > 29	#include "../../codecs/hdac_hdmi.h"
>     30	
>     31	static struct snd_soc_jack skylake_headset;
>     32	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Thanks
-- 
~Vinod
