From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
	audio codec
Date: Mon, 29 Sep 2008 18:32:03 +0100
Message-ID: <20080929173202.GA18699@sirena.org.uk>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
	<20080929165404.GA16109@sirena.org.uk>
	<48E10ABE.5030703@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BC21244AF
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 19:32:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E10ABE.5030703@boundarydevices.com>
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

On Mon, Sep 29, 2008 at 10:05:02AM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > No, the I2C and SPI support should both be part of the driver.  The

> Seems to me a Kconfig option would be more efficient. Otherwise, one of the
> two options is just going to waste space.

We need to support building for both I2C and SPI simultaneously in order
to allow kernels supporting multiple boards to be built.  If the
selection is done at build time then the number of configurations that
can be built in a single image is restricted needlessly.

I'd ack patches which made it possible to configure one or the other out
but given the tiny amount of glue required I'd personally not bother
writing that.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
