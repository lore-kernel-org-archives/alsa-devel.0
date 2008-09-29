From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
 audio codec
Date: Mon, 29 Sep 2008 10:58:43 -0700
Message-ID: <48E11753.3090100@boundarydevices.com>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
	<20080929165404.GA16109@sirena.org.uk>
	<48E10FEA.7000300@boundarydevices.com>
	<20080929173937.GB18699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 18499244CA
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 19:59:01 +0200 (CEST)
In-Reply-To: <20080929173937.GB18699@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Sep 29, 2008 at 10:27:06AM -0700, Troy Kisky wrote:
>> Mark Brown wrote:
> 
>>>> codec. Can the I2c code be moved into the board directory? I have my spi code
>>>> in the board directory and just pass the write function pointer. i.e.
> 
>>> No, the I2C and SPI support should both be part of the driver.  The
>>> driver should just be modified to allow both I2C and SPI support to be
>>> compiled in and let the board driver register the appropriate one at run
>>> time.
> 
>> Can you please explain to me why they should both be part of the codec driver?
> 
> Neither is board specific - there's no sense in having each board that
> needs SPI support replicate the code to register a SPI device and do the
> marshalling of data for SPI writes.  What motivation do you see for not
> doing that?
> 

It just doesn't seem to be logically a part of the codec code. And I didn't register
an spi device. I just linked the simple spi routines with my board code (separate file).

Plus, it seems a lot of code duplication if each codec registers the spi device
and I2C device. Are there more boards, or more codecs???

Thanks
Troy
