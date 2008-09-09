From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Tue, 09 Sep 2008 10:03:58 +0100
Message-ID: <1220951038.17091.177.camel@odin>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809082127.13653.gineera@aspect135.co.uk>
	<20080908205105.GA32649@sirena.org.uk>
	<200809090945.35359.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 9769824528
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 11:04:05 +0200 (CEST)
In-Reply-To: <200809090945.35359.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Cliff Cai <cliff.cai@analog.com>, ALSA devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-09-09 at 09:45 +0100, Alan Horstmann wrote:
> On Monday 08 September 2008 21:51, you wrote:
> > On Mon, Sep 08, 2008 at 09:27:13PM +0100, Alan Horstmann wrote:
> > > Attached and here inline is the small change we applied to ensure the
> > > byte order is correct in the _spi_write function.  Note we observed the
> > > spi bus
> >
> > I take it you're happy to give this your Signed-off-by?
> 
> Yes, fine, though obviously we haven't tested this with any other soc systems.
> 
> wm8731_spi_write_byte_order.patch
> 
> Ensure wm8731_spi_write byte order is consistent regardless of endianess.
> 
> Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>
> 

Might be worth rolling this out to other SPI capable codecs too.....

Liam 
