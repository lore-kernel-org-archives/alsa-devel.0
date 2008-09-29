From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
	audio codec
Date: Mon, 29 Sep 2008 19:30:46 +0100
Message-ID: <20080929183045.GA21010@sirena.org.uk>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
	<20080929165404.GA16109@sirena.org.uk>
	<48E10FEA.7000300@boundarydevices.com>
	<20080929173937.GB18699@sirena.org.uk>
	<48E11753.3090100@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 57366244DF
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 20:30:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E11753.3090100@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 10:58:43AM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > Neither is board specific - there's no sense in having each board that
> > needs SPI support replicate the code to register a SPI device and do the
> > marshalling of data for SPI writes.  What motivation do you see for not
> > doing that?

> It just doesn't seem to be logically a part of the codec code. And I didn't register

The data marshalling is a function of the codec hardware - whatever it
has been hooked up to the register address and data values written are
going to need to be in a given format when they hit the codec.  The SPI
and I2C APIs abstract away the details of the actual controller from the
codec driver.

> an spi device. I just linked the simple spi routines with my board code (separate file).

I'm not sure which simple SPI API you're referring to here?  In any
case, ASoC is shortly going to pretty much require a struct device for
the codec so it will be required to have a device of some kind
registered.

> Plus, it seems a lot of code duplication if each codec registers the spi device
> and I2C device. Are there more boards, or more codecs???

In the device model the board registers the *device*, the codec (or
whatever) driver registers the *driver* - the two are separated.  The
driver core then instantiates the drivers based on what the board
specifies.  There's not really any overlap between the two areas that I
can see.

Otherwise could you explain in more detail where you see the code
duplication coming from?
