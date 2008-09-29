From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
 audio codec
Date: Mon, 29 Sep 2008 14:15:14 -0700
Message-ID: <48E14562.5030906@boundarydevices.com>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
	<20080929165404.GA16109@sirena.org.uk>
	<48E10FEA.7000300@boundarydevices.com>
	<20080929173937.GB18699@sirena.org.uk>
	<48E11753.3090100@boundarydevices.com>
	<20080929183045.GA21010@sirena.org.uk>
	<48E12789.50006@boundarydevices.com>
	<20080929195011.GC21010@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 99BE52455D
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 23:15:31 +0200 (CEST)
In-Reply-To: <20080929195011.GC21010@sirena.org.uk>
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

> 
> That said, there is an issue with this at the minute due to the fact
> that the core does not yet use the device model properly and
> (essentially) hangs all the drivers off the codec device which leads to
> having both ai23_probe() which registers the I2C driver and
> aic23_codec_probe().  This is half way to being rectified (the code
> exists but is in the process of being merged) so that what happens is
> that all the components of the system register with the ASoC core after
> being probed normally from registrations done in the board init code or
> similar.  This will remove all the socdev interaction from the codec
> driver which is, I think, what you're getting at?

Thanks for the explanation and status update. I have no problem with doing
both in the codec until this code is merged.


Thanks
Troy
