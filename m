From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
	audio codec
Date: Mon, 29 Sep 2008 17:54:05 +0100
Message-ID: <20080929165404.GA16109@sirena.org.uk>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D972448E
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 18:54:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E1068E.7020908@boundarydevices.com>
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

On Mon, Sep 29, 2008 at 09:47:10AM -0700, Troy Kisky wrote:

> Great. I just finished the same thing for davinci but using spi.
> I was waiting until the adc issue I mentioned yesterday was resolved before posting it.
> I'm glad I won't have to now. But my board also has I2c, just not with this

It'd be great if you could work with Arun to ensure that all the
features which you are using are supported in the driver - it looks like
at least SPI support will need to be added.

> codec. Can the I2c code be moved into the board directory? I have my spi code
> in the board directory and just pass the write function pointer. i.e.

No, the I2C and SPI support should both be part of the driver.  The
driver should just be modified to allow both I2C and SPI support to be
compiled in and let the board driver register the appropriate one at run
time.
