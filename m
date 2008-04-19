From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Sat, 19 Apr 2008 14:18:38 +0200
Message-ID: <20080419121838.GA1680@buzzloop.caiaq.de>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 953BD24D4E
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 14:18:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080419112425.GA18877@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Apr 19, 2008 at 12:24:26PM +0100, Mark Brown wrote:
> > the registers in questions are purely in its scope. So the idea is to
> > set up the GPIO's functions via alsa controls and handle its events in
> > some board-related code as this is really not abstractable. One could,
> > however, do this setup in machine-related code within the asoc
> > environment.
> 
> The usual approach is to have multi-function pins on CODECs are
> controlled by the ASoC codec driver based on configuration supplied by
> the machine driver. 

I was looking for a mechanism to pass such information around but didn't
manage to find any. Which way would you suggest? The approach in my
patch causes as less overhead as possible at it simply reuses the asoc's
widgets, I though.

> Their use tends to be heavily constrained by the
> board design so it usually makes more sense to let the machine driver
> set things up and deal with exposing controls for any configurability
> that user space can exercise.

Ok, but why not let the codec driver expose all the functionality it can
offer for setting up a certain GPIO and use this alsa control either
from user space or from the asoc machine part? I think that's the most
flexible way at all, no?

And when it comes to setting or getting a GPIO's state I see no way to
access such special purpose functions of the codec driver. At least,
'struct snd_soc_codec' doesn't give me any hints how to achive that.

> Most of the time when GPIO lines on CODECs are used they tend to be
> controlling other bits of the audio subsystem anyway (eg, power for
> simple amplifiers) - most SoCs have plenty of GPIOs on-board and they're
> usually much easier to work with due to being memory mapped on the CPU.

Well, I didn't implement that just because it wasn't done yet ;) In the
setup I'm working on, one GPIO is needed to control peripherals next to
it in the board layout where routing constraints become part of the
game. And the other one is connected to one of the processor's GPIO to
catch an interrupt from the AIC3x when a headset is plugged in. Thus, we
really need to support them both. Others may have different use for
them, just have a look at the possible functions of those GPIOs.

Best regards,
Daniel
