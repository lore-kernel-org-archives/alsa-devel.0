From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patches_v2] Reforming S3C I2S towards supporting
	I2Sv4
Date: Wed, 5 May 2010 15:00:39 +0100
Message-ID: <20100505140039.GC7139@rakim.wolfsonmicro.main>
References: <1272351294-3650-1-git-send-email-jassi.brar@samsung.com>
	<20100504005319.GJ2589@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 641B224723
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 16:00:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100504005319.GJ2589@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 04, 2010 at 01:53:19AM +0100, Ben Dooks wrote:
> On Tue, Apr 27, 2010 at 03:54:54PM +0900, Jassi Brar wrote:
> > I am going to resubmit pending last 11 patches of the original series
> >  http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/025920.html
> > No changes have been made other than moving dma_data from snd_soc_dai to
> > snd_soc_pcm_stream in the new I2Sv4 controller driver.

> All these look fine.

> Acked-by: Ben Dooks <ben-linux@fluff.org>

Now we've got all the relevant acks I tried to apply these against my
for-2.6.35 branch but it looks like there's been some drift somewhere
along the line since the patches were first posted and there's problems
applying.  Could you please rebase against for-2.6.35 and resend?

> It should also be ok to merge the s3c2412 DMA updates via the same
> tree as there's not any intention to be touching this part of the tree
> before the next merge.

If someone could submit these to me that'd be great.
