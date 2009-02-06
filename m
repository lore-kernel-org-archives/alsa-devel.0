From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.30] ASoC: optimize init sequence
	of	Freescale MPC8610 sound drivers
Date: Fri, 6 Feb 2009 11:46:59 +0000
Message-ID: <20090206114613.GC8723@sirena.org.uk>
References: <1233878162-30569-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FEFA2432F
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 12:47:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233878162-30569-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2009 at 05:56:02PM -0600, Timur Tabi wrote:
> In the Freescale MPC8610 sound drivers, relocate all code from the _prepare
> functions into the corresponding _hw_params functions.  These drivers assumed
> that the sample size is known in the _prepare function and not in the
> _hw_params function, but this is not true.
> 
> Move the code in fsl_dma_prepare() into fsl_dma_hw_param().  Create
> fsl_ssi_hw_params() and move the code from fsl_ssi_prepare() into it.
> 
> Turn off snooping for DMA operations to/from I/O registers, since that's not
> necessary.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
