From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 16:27:34 +0200
Message-ID: <20130508142734.GB12155@balto.lan>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
 <20130508123225.GK7478@sirena.org.uk>
 <20130508131020.GA30503@balto.lan>
 <20130508135413.GR7478@sirena.org.uk>
 <20130508141723.GA12155@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4804D2619F5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 16:27:44 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id e11so1893552wgh.2
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 07:27:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130508141723.GA12155@balto.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2013 at 04:17:23PM +0200, Fabio Baltieri wrote:
> > > If I understood the problem correctly you do that when you want to cut
> > > power completely to some peripherals to avoid spurious current paths,
> > > and that should not be the case for the audio codec, especially in this
> > > case where it's part of a big multifuntion IC.
> > 
> > Being a MFD should have nothing to do with this?
> 
> Ok, what I'm trying to say is that the codec used in this platform
> should be able to handle sleep modes without requiring any
> reconfiguration of the digital interface on the SoC side.  In support of
> this the fact that the STE fork of the driver does not do that, and the
> same goes for all other ASoC drivers currently in mainline.

And by the way, if the current code is *really* setting the digital
audio bus pins in hi-z mode (without any pull-up/down/keeper) as it
claims, this is not just usless, it's plain wrong.  The bus should never
be left floating on both sides, right?

Fabio

-- 
Fabio Baltieri
