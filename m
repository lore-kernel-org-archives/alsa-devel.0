From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: hook for codec control updates and
	clock	controls
Date: Mon, 8 Dec 2008 09:48:43 +0000
Message-ID: <20081208094843.GA7094@sirena.org.uk>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 963AF103811
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 10:48:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081208000450.GA30181@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 01:04:50AM +0100, Daniel Mack wrote:
> On Sun, Dec 07, 2008 at 07:02:40PM +0000, Mark Brown wrote:

> > The clocking is the responsibility of the board driver - often the
> > clocks are disabled while the link is inctive but this up to the board
> > driver (and ultimately the hardware design).

> That makes sense. However, there is this special case I'm facing here -
> the codec's volume settings are updated and the board driver doesn't
> notice that, so it can't react and switch on the clock for some time.

The normal thing would be to never turn off the master clock.  This is a
very common setup - many systems will have a dedicated crystal for the
codec which can never be disabled.  Do you actually need to turn off the
clock (and are you sure that the codec is happy about that)?

> The idea is to provide a way for codecs to signal the need for the
> master clock (or whatever clock) to be applied externally. And it's
> actually not important what it takes to actually do that - a generic way
> the board support code can use would be good.

This would need to at least specify the clock that needs to be turned
on and how many cycles it needs to be turned on for.  I'm having a hard
time getting enthusiastic about that, it seems like too much software
especially since we can't use the clock API for any of this due to the
inconsistent implementations.

In what circumstances does the codec need the clock?  What are the
negative consequences of it not being enabled?  If it only needs the
clock when bypass paths are active then we should just fix the bias
level control to set bias on when only analogue paths are active (this
ought to be done anyway) and the machine driver can use the bias level
callback to enable the clocks.  If it needs it at other times are you
sure that the device is supposed to tolerate being used with the MCLK
removed?
