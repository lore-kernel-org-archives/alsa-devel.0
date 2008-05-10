From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH,
	RFC] ASoC: update pxa2xx-ssp to work with	current mainline
Date: Sat, 10 May 2008 14:35:01 +0100
Message-ID: <1210426501.20475.128.camel@odin>
References: <1210423813.3876.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 718912441F
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 15:35:03 +0200 (CEST)
In-Reply-To: <1210423813.3876.10.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2008-05-10 at 14:50 +0200, Philipp Zabel wrote:
> This patch against the ASoC dev branch updates pxa2xx-ssp to work with
> current mainline. I only made minimal changes to clock/register access
> and some dbg->pr_debug cleanup, I guess the DMA setup should be
> reworked
> properly, but I'm not familiar enough with that.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>  sound/soc/pxa/pxa2xx-ssp.c |  266
> +++++++++++++++++++++++++-------------------
>  1 files changed, 151 insertions(+), 115 deletions(-)
> 

Thanks, applied to ASoC git.

Liam
