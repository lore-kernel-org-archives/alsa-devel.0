From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: S3C2412: DMA: Remove I2S FIFO address
Date: Fri, 7 May 2010 16:36:19 +0100
Message-ID: <20100507153619.GA25793@rakim.wolfsonmicro.main>
References: <20100505140039.GC7139@rakim.wolfsonmicro.main>
	<1273195299-12181-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 447781038A4
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 17:36:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1273195299-12181-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 10:21:39AM +0900, Jassi Brar wrote:
> The S3C DMA API doesn't make use of hw_addr.to/from and also
> the FIFO addresses are provided from the I2S drivers. So these
> fields are redundant.
> This patch removes the hw_addr.to/from fields for I2S and the
> inclusion of header, paving way for the header to be moved closer
> to the I2S controller drivers.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Applied, thanks.
