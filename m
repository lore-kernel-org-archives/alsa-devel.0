From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] sound/soc/fsl/p1022_ds.c: add missing
	of_node_put
Date: Mon, 22 Aug 2011 23:30:01 +0100
Message-ID: <20110822223000.GD30609@opensource.wolfsonmicro.com>
References: <1313823721-16930-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 289D42438A
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:30:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313823721-16930-1-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Axel Lin <axel.lin@gmail.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 20, 2011 at 09:02:00AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> dma_channel_np has been accessed at this point, so decrease its reference
> count before leaving the function.

Applied, thanks.
