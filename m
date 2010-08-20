From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] asoc/multi-component: add support for
 separate codec DAIs to the fsl_dma driver
Date: Fri, 20 Aug 2010 10:45:27 +0100
Message-ID: <20100820094526.GC13668@rakim.wolfsonmicro.main>
References: <1282254222-19990-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14CD0243EA
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:45:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282254222-19990-1-git-send-email-timur@freescale.com>
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

On Thu, Aug 19, 2010 at 04:43:42PM -0500, Timur Tabi wrote:
> Some codecs have separate DAIs for playback and capture, so the DMA driver
> should allocate a DMA buffer only for the streams that are valid when the
> driver is opened.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
