From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] asoc/multi-component: add support for
 the Freescale P1022 DS reference board
Date: Fri, 20 Aug 2010 12:14:14 +0100
Message-ID: <20100820111414.GJ13668@rakim.wolfsonmicro.main>
References: <1282255900-20515-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 591DD1038EC
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 13:14:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282255900-20515-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 05:11:40PM -0500, Timur Tabi wrote:
> The Freescale P1022 is a dual-core e500-based SOC with multimedia capabilities,
> specifically the same SSI audio controller on the MPC8610.  The P1022 DS
> reference board includes a P1022 and a Wolfson Microelectronics WM8776
> codec.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

> +static struct device_node *get_node_by_phandle_name(struct device_node *np,
> +	const char *name, const char *compatible)
> +{

This and a few of the other functions look like they ought to be moved
somewhere more generic - they don't look specific to this driver at all.
