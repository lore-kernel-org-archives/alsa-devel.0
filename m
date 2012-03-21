From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [v3] powerpc/8xxx: remove 85xx/86xx
	restrictions from fsl_guts.h
Date: Wed, 21 Mar 2012 12:22:12 -0500
Message-ID: <7B496830-BF31-451E-9BE6-BB2FEE9B5BD0@kernel.crashing.org>
References: <1332173199-25877-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9CC24141
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 18:22:18 +0100 (CET)
In-Reply-To: <1332173199-25877-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


On Mar 19, 2012, at 11:06 AM, Timur Tabi wrote:

> Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from fsl_guts.h.
> The check was originally intended to allow the same header file to
> be used on 85xx and 86xx systems, even though the Global Utilities
> register could be different.  It turns out that they're not actually
> different, and so the check is not necessary.  In addition, neither
> macro is defined for 64-bit e5500 kernels, so that causes a build
> break.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> The ASoC part of this patch applies cleanly to the ASoC for-3.4 branch,
> so this patch should not cause any merge conflicts if carried on the
> PowerPC branch, so I suggest that Kumar pick this up for 3.4 (it fixes a
> potential 64-bit book-e build break), with an ACK from Mark. 
> 
> arch/powerpc/include/asm/fsl_guts.h        |   26 +++++---------------------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |    2 +-
> arch/powerpc/platforms/85xx/p1022_ds.c     |    4 ++--
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 +-
> sound/soc/fsl/mpc8610_hpcd.c               |    8 ++++----
> sound/soc/fsl/p1022_ds.c                   |   10 +++++-----
> 7 files changed, 19 insertions(+), 35 deletions(-)

applied

- k
