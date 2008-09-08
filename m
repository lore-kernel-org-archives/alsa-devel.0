From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [GIT PULL] unify two pxa sound drivers
Date: Mon, 08 Sep 2008 10:05:33 +0100
Message-ID: <1220864734.17091.76.camel@odin>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id C634D2452A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:05:40 +0200 (CEST)
In-Reply-To: <20080908085339.GA31573@doriath.ww600.siemens.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 12:53 +0400, Dmitry Baryshkov wrote:
> Hi,
> 
> Please consider this changeset. It was partially tested, but additional
> testing will be appreciated. pxa3xx was only compile tested.
> 
> The following changes since commit 6a55617ed5d1aa62b850de2cf66f5ede2eef4825:
>   Linus Torvalds (1):
>         Linux v2.6.27-rc4
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/dbaryshkov/zaurus-2.6.git pxa2xx-asoc-cleanup
> 
> Dmitry Baryshkov (4):
>       Permit simultaneous compilation of both PXA AC97 drivers
>       Separate common pxa2xx-ac97 code
>       Make pxa-ac97-lib separate module
>       Separate common pxa2xx-pcm code
> 
> Russ Dill (1):
>       pxa2xx-lib: support building for several pxa's
> 
>  arch/arm/mach-pxa/include/mach/pxa-regs.h |    4 +-
>  include/sound/pxa2xx-lib.h                |   45 +++++
>  sound/arm/Kconfig                         |    9 +-
>  sound/arm/Makefile                        |    4 +
>  sound/arm/pxa2xx-ac97-lib.c               |  297 +++++++++++++++++++++++++++++
>  sound/arm/pxa2xx-ac97.c                   |  247 ++----------------------
>  sound/arm/pxa2xx-pcm-lib.c                |  277 +++++++++++++++++++++++++++
>  sound/arm/pxa2xx-pcm.c                    |  252 +-----------------------
>  sound/arm/pxa2xx-pcm.h                    |   13 +-
>  sound/soc/pxa/Kconfig                     |    3 +
>  sound/soc/pxa/pxa2xx-ac97.c               |  272 +-------------------------
>  sound/soc/pxa/pxa2xx-i2s.c                |   26 ++-
>  sound/soc/pxa/pxa2xx-pcm.c                |  265 +-------------------------
>  sound/soc/pxa/pxa2xx-pcm.h                |   15 --
>  14 files changed, 707 insertions(+), 1022 deletions(-)
>  create mode 100644 include/sound/pxa2xx-lib.h
>  create mode 100644 sound/arm/pxa2xx-ac97-lib.c
>  create mode 100644 sound/arm/pxa2xx-pcm-lib.c
> 

I assume most changes are mechanical. Could you post for review too.

Thanks

Liam 
