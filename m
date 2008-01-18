From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] Update MPC8610 HPCD to
	support audio drivers
Date: Fri, 18 Jan 2008 10:45:17 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801181042290.31902@blarg.am.freescale.net>
References: <12006698934064-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 696A2245F0
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 17:47:37 +0100 (CET)
In-Reply-To: <12006698934064-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Jan 2008, Timur Tabi wrote:

> Update the MPC8610 HPCD files to support the audio driver.  Update
> booting-without-of.txt with information on the SSI device.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Rebased for Kumar's repo.
>
>  Documentation/powerpc/booting-without-of.txt |   41 ++++++
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  113 +++++++++++++++++-
>  arch/powerpc/configs/mpc8610_hpcd_defconfig  |  171 +++++++++++++++++++++++++-
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   15 +++
>  4 files changed, 336 insertions(+), 4 deletions(-)

applied.

- k
