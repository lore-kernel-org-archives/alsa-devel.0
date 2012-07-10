From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: select PPC_CLOCK unconditionally
	for FSL_SOC
Date: Tue, 10 Jul 2012 07:24:41 -0500
Message-ID: <881CAA24-930D-4708-9911-80C9B40B0F3C@kernel.crashing.org>
References: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id C08D124AA1
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 14:24:44 +0200 (CEST)
In-Reply-To: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


On Mar 30, 2012, at 12:38 AM, Shawn Guo wrote:

> Freescale PowerPC SoCs share a number of IP blocks with Freescale
> ARM/IMX SoCs, FlexCAN, SSI, FEC, eSDHC, USB, etc.  There are some
> effort consolidating those drivers to make them work for both
> architectures.
> 
> One outstanding difference between two architectures is ARM/IMX will
> turn off module clocks during platform initialization for power saving
> and expects drivers manage clocks using clk API, while PowerPC
> mostly does not do that, and thus does not always build in clk API.
> 
> Listing all those driver Kconfig options in "select PPC_CLOCK if" seems
> not scalable for long term maintenance, and could easily introduce
> Kconfig recursive dependency.  This patch chooses to select PPC_CLOCK
> unconditionally for FSL_SOC to always build clk API for PowerPC in.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> arch/powerpc/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
