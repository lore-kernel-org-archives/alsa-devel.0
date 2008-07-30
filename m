From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH] pxa2xx-lib: support building for several
	pxa's
Date: Thu, 31 Jul 2008 02:41:21 +0400
Message-ID: <bc64b4640807301541m3f070da9o1c44ec14e160e829@mail.gmail.com>
References: <1217441805.20421.4.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id B12FD24469
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 00:41:22 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so44574and.80
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 15:41:21 -0700 (PDT)
In-Reply-To: <1217441805.20421.4.camel@ubuntu>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russ Dill <russ.dill@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, eric.miao@marvell.com
List-Id: alsa-devel@alsa-project.org

Hi,

2008/7/30 Russ Dill <russ.dill@gmail.com>:
> Here's a version of the third patch in the series without all the
> #ifdef's. Just a quick question for Dmitry, why all the if (!
> cpu_is_pxa3xx())'s around the pxa_gpio_mode's? Also, there was a build
> error when just building the sound/arm pxa2xx-ac97.

Good!

AFAIR pxa_gpio_mode isn't valid for the the pxa3xx, so cpu_is_pxa3xx().

>
> Support building pxa2xx-lib for several pxa chip versions by making code
> run-time selected, not only compile-time
>
> Signed-off-by: Russ Dill <russ.dill@gmail.com>
> ---
>  include/asm-arm/arch-pxa/pxa-regs.h |    4 +-
>  sound/arm/Kconfig                   |    2 +-
>  sound/arm/pxa2xx-ac97-lib.c         |  174 ++++++++++++++++------------------
>  sound/soc/pxa/pxa2xx-i2s.c          |   16 ++-
>  4 files changed, 95 insertions(+), 101 deletions(-)
>
-- 
With best wishes
Dmitry
