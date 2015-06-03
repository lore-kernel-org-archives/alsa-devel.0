From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [asoc:topic/arizona 1/7]
	sound/soc/codecs/arizona.h:122:2:	note: in expansion of macro
	'ARIZONA_MUX_ENUMS'
Date: Wed, 3 Jun 2015 10:09:42 +0100
Message-ID: <20150603090942.GA3902@opensource.wolfsonmicro.com>
References: <201506030445.WHoNgi04%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19291260418
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 11:09:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201506030445.WHoNgi04%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, fengguang.wu@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2015 at 04:51:49AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/arizona
> head:   69a6582eeb17dc083b2510f1ca2eaa54ff679b49
> commit: 21a37e39e02d7f57691219fee88cf1d48a74e5bd [1/7] ASoC: arizona: Use auto disable muxes for routing
> config: xtensa-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 21a37e39e02d7f57691219fee88cf1d48a74e5bd
>   # save the attached .config to linux build tree
>   make.cross ARCH=xtensa 
> 
> All error/warnings:
> 
>    In file included from sound/soc/codecs/wm5102.c:33:0:
> >> include/linux/mfd/arizona/registers.h:646:50: error: expected ')' before numeric constant
>     #define ARIZONA_EQ1MIX_INPUT_1_SOURCE            0x880

Seems to just a false positive because the patch adding
SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL isn't on the topic/arizona
branch. I assume this will sort itself out as the branches merge
through.

Thanks,
Charles
