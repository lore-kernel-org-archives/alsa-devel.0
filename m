From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8974 on AT91SAM9263EK
Date: Thu, 24 Nov 2011 13:49:43 +0000
Message-ID: <20111124134943.GA2509@sirena.org.uk>
References: <A63F82CB7CD649AFAF623D416B2C30E9@SWEntwicklung>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B3B0103A90
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 14:49:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <A63F82CB7CD649AFAF623D416B2C30E9@SWEntwicklung>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthias Wieloch <matthias_wieloch@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 02:45:10PM +0100, Matthias Wieloch wrote:

*Always* CC maintainers.

> After analysing with an oscilloscope I'm sure that I2C is working and that
> the codecs responses at least with ACK. But I couldn't see any changes on
> the SSC lines.
> So far I disabled all peripherals and GPIOs that use the same pins as SSC1.
> Looking at the register values the SSC peripheral seems not to be
> initialised although the application flow is similar to the AT91SAM9g20EK I
> based my code on.

I'd suggest contacting the Atmel folks about this.

> What I find strange is that the WM8974 codec does not provide a .set_sysclk
> function although most other codecs do. Do I have to call other functions to
> set up the SSC or rather where should these be set?

To repeat what I said to you on IRC the other day this is one of Liam's
old drivers and therefore uses set_clkdiv() instead of set_sysclk().

Also, have you set up an audio path to an output?  If there's no audio
path the system won't attempt to power anything up.
