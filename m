From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] sound/soc/fsl/fsl_dma.c: add missing
	of_node_put
Date: Mon, 22 Aug 2011 23:27:20 +0100
Message-ID: <20110822222720.GA29473@opensource.wolfsonmicro.com>
References: <1314022961-27513-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14B6324337
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:27:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314022961-27513-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, julia@diku.dk, linuxppc-dev@lists.ozlabs.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 09:22:41AM -0500, Timur Tabi wrote:
> of_parse_phandle increments the reference count of np, so this should be
> decremented before trying the next possibility.
> 
> Since we don't actually use np, we can decrement the reference count
> immediately.

Applied, thanks.
