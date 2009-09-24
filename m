From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with mplayer and OSS on at91sam9g20(kernel
 2.6.30)
Date: Thu, 24 Sep 2009 07:57:56 -0700
Message-ID: <20090924145755.GB5105@sirena.org.uk>
References: <4ABB67CA.6000003@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl01-sjpop.stsn.net (s-utl01-sjpop.stsn.net [72.254.0.201])
	by alsa0.perex.cz (Postfix) with SMTP id B6EA01038C7
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 16:59:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ABB67CA.6000003@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 24, 2009 at 02:36:26PM +0200, Sedji Gaouaou wrote:

> -- 2 error messages to note -------------------------
> mplayer:
> "[AO OSS]setup: driver doesn't support SNDCTL_DSP_GETOSPACE :-("

This is just going to be a knock on effect of the hw_params failing, I
expect...

> kernel:
> "asoc: machine hw_params failed"

...for which I'd suggest drilling down into the function to see which
operation fails.  Looking at the code I'd expect it's getting upset
because it's being called with an invalid rate (OSS emulation calls
hw_params with partially initialised parameters) but you're not seeing
the log message that ought to be printed when that happens.  Some trace
showing what causes it to return an error ought to point out the
culprit.  The usual way to fix these is to ignore any errors in the
function which isn't ideal but is needed with the way OSS emulation
works.

I won't have access to my sam9g20 board until next week to look at this
myself.  
