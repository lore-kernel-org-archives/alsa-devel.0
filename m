From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: Help for writting an ASoC driver
Date: Tue, 7 Apr 2009 18:26:34 -0500
Message-ID: <fb44c3530904071626q22e41db2s76f6089771de74c2@mail.gmail.com>
References: <fb44c3530904071018o542cb622k6ab9b939b3144c78@mail.gmail.com>
	<20090407221935.GB8465@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id CC44F2442B
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 01:26:35 +0200 (CEST)
Received: by qyk38 with SMTP id 38so5217274qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 07 Apr 2009 16:26:34 -0700 (PDT)
In-Reply-To: <20090407221935.GB8465@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sorry for not being clear, I'm writting a driver for an external codec to
use instead of twl4030 not for the beagleboard
I'll check the clocking, thanks.


On Tue, Apr 7, 2009 at 5:19 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Tue, Apr 07, 2009 at 12:18:25PM -0500, Ernesto Torres wrote:
>
> > Hi, i'm new to alsa and i would like some advice on where to get
> information
> > about writing an ASoC driver it would be for the beagle board, since is
> the
> > board i have available. I have already made some progress initializing
> and
>
> There is already a drier for the Beagle board in the kernel - see the
> omap3beagle driver.
>
> > I still don't know the exact way for playing via pcm with aplay or the
> order
> > of the callbacks. I have checked the web for info but not much about
> ASoC,
> > just the documentation with the linux kernel.
>
> ASoC jsust presents a standard sound card so applications such as aplay
> work as they normally do.  The callbacks are all called in the same
> order as the standard ALSA equivalents are, you can check how exactly
> things are mapped from the standard ALSA callbacks into ASoC in
> soc-core.c.
>
> > My driver actually tries to play with aplay, but gets stuck in :
> omap-pcm.c:
> > omap_pcm_pointer
> > It just won't send the frames.
>
> At a guess you've not got the clocking set up properly - either the pins
> for the clock signals are not configured in the appropriate mode or an
> inappropriate clock configuration has been set up in your machine
> driver.
>



-- 
___________
EhTd
