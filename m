From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 4/7] ASoC: S3C64XX: USE DMA info from
	platform data
Date: Thu, 28 Jan 2010 04:27:15 +0000
Message-ID: <20100128042715.GR10014@trinity.fluff.org>
References: <1260332978-11475-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209110024.GC19851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E99A103806
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 05:27:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091209110024.GC19851@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 11:00:24AM +0000, Mark Brown wrote:
> On Wed, Dec 09, 2009 at 01:29:38PM +0900, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jassi.brar@samsung.com>
> 
> > Instead of hardcoding DMA channel numbers and address, for each controller
> > in the driver, let the information be read from platform data.
> 
> > Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> 
> OK, but this needs to go along with the arch/arm side to avoid breaking
> the driver.

I've applied the arch/arm side of the patch already, as this was quite
eassy to do. It is then a case of whether I should take the patch to
remove it from sound/soc/s3c24xx/s3c64xx-i2s.c or should we wait until
my/rmk's tree has been merged into the mainline?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
