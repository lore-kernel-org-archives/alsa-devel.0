From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
	MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 14:42:06 +0100
Message-ID: <20080613134206.GA29575@rakim.wolfsonmicro.main>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D421244DF
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 15:42:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 12, 2008 at 10:57:39PM -0400, Jon Smirl wrote:

> In my model a lot of the code in your fabric driver would be pushed
> into the ssi driver. So if you used ssi and a codec in the standard
> manner, the board wouldn't need a fabric driver at all. That would
> probably be the case for most AC97/HDA systems.

I'd certainly like to see some standard support for setting up at least
AC97 DAI links automatically based on the probed codec.  That bit could
probably be done by the core.  HDA should be amenable to this model too
but I haven't looked at it in anything more than passing detail yet.

That's only part of the story, though.  What's much more tricky is
making the decision that you've got all the components for the sound
subsystem - for example, there are AC97 codecs like the WM9712 and
WM9713 which also have I2S interfaces.  You also get systems which need
to jump through hoops to set up the clocking since they're doing
non-standard things.  Simple systems would probably need an explict flag
to say that they could be handled as such, which isn't a million miles
off having something to load a generic machine driver.

Things get a lot more tricky for I2S due to the complexity of the
available clocking configurations - there are so many possible ways of
connecting devices, especially once you start to take into account codec
internal clocking and systems which support more than two devices 
