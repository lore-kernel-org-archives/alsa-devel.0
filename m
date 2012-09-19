From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: fsl: remove unnecessary call to
 dma_unmap_single
Date: Tue, 18 Sep 2012 22:35:40 -0400
Message-ID: <20120919023539.GF8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-3-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C533A26512E
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:35:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347657278-25295-3-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 04:14:36PM -0500, Timur Tabi wrote:
> Remove a call to dma_unmap_single() from the PowerPC ASoC DMA driver.  The
> buffer is allocated and not actually mapped, so the unmap call doesn't
> make sense.  It was probably left over from some early version of the driver.
> 
> This bug was unnoticed for so long because the DMA mapping functions normally
> don't do anything on PowerPC.

Applied, thanks.
