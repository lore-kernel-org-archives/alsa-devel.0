From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add
	DAPM	links between codec and cpu DAI
Date: Fri, 30 Aug 2013 17:10:05 +0100
Message-ID: <20130830161005.GZ6617@n2100.arm.linux.org.uk>
References: <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
 <20130823165800.GB30617@sirena.org.uk>
 <20130823174505.GQ6617@n2100.arm.linux.org.uk>
 <CAOyKLY_mQzPxHAg2RFSMY89uxp-0-OAf6fC=gVY0i+pQhv4iHQ@mail.gmail.com>
 <20130830112705.GU6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D29E72618EE
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 18:10:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130830112705.GU6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 30, 2013 at 12:27:05PM +0100, Russell King - ARM Linux wrote:
> 1. The combining of the CPU and platform code(s) under one device is
>    absolutely no problem for ASoC, there's multiple drivers which do this
>    already.  While this is a true statement, it creates the bug at the
>    heart of this thread - and the bug _occuring_ has nothing to do with
>    DPCM.  The bug is caused solely by the combining of the two components.

Right, having gone back and looked at this in-depth again, and tried some
experiments, I no longer need this problem fixed for the non-DPCM code
to work, but I do still need to do this:

> 4. By adding the AIFs and routes, I'm bypassing/abusing the ASoC DAI core.
>    If this were to be the case, why does your DPCM driver set them up.
>    Therefore, my conclusion is that Mark was wrong about this too.  Yes,
>    it may be that for the time being it's not that appealing, because as
>    DPCM doesn't work in mainline, I'm unable to separate the DAI link
>    between the CPU and the Codec.  That doesn't make the creation of
>    the routes any more wrong when they're the exact same routes which
>    need to be created for DPCM - especially when they're relied upon for
>    there to be any audio output what so ever from the driver.

so I can detect which output paths to enable.  I will be posting updated
patches shortly, which will just be those which Mark hasn't taken yet.
