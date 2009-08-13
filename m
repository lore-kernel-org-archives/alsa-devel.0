From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: tlv320aic3x: Allow driver to use already
 registered i2c device
Date: Thu, 13 Aug 2009 14:48:27 +0100
Message-ID: <20090813134827.GE21652@rakim.wolfsonmicro.main>
References: <20090806230204.992074844@fluff.org.uk>
	<20090807094301.GA639@sirena.org.uk>
	<4A84148E.7050307@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBD4E103878
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 15:48:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A84148E.7050307@simtec.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 02:26:38PM +0100, Ben Dooks wrote:
> Mark Brown wrote:

> >Why would you want to do this?  I suspect that perhaps you want to
> >convert the driver to use the standard device model instead but without
> >understanding your motivation for making this change it is very hard to
> >comment in detail.

> The device is registered by the code that sets the initial devices
> up that have been passed from the bootloader, thus the tlv320aic33
> fails to initialise as there is already an i2c device on the i2c bus
> when it comes along.

OK, that's what I thought.  You need to convert the driver to use the
normal device model probe methods rather than using bodges like this.
See drivers like wm8731 for an example of how the conversion looks.
