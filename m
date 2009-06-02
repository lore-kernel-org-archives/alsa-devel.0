From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: Re: ASoC: TWL4030 driver support multi channel playback
Date: Tue, 2 Jun 2009 15:32:38 +0530
Message-ID: <ef0d8a250906020302q4c96dfb2y27dd5664c7f6ea9c@mail.gmail.com>
References: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
	<200906020816.41806.peter.ujfalusi@nokia.com>
	<20090602093707.GB4046@sirena.org.uk>
	<ef0d8a250906020254w3ecc60d2w7c196765e48eab25@mail.gmail.com>
	<20090602095845.GA20046@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 68FF624509
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 12:02:40 +0200 (CEST)
Received: by qyk1 with SMTP id 1so11035705qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 03:02:39 -0700 (PDT)
In-Reply-To: <20090602095845.GA20046@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2009/6/2 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Tue, Jun 02, 2009 at 03:24:11PM +0530, Naveen Krishna Ch wrote:
>
> > I am done with the entire back porting of ASoC.
> >
> > I can see the dapm widgets getting ON/OFF and codec registers being
> changed.
> >
> > But, there is no audio out.  Am i missing somthing
> >
> > A direct aplay should play the audio on the headset, right?
>
> I am not familiar with the TWL4030, you should ask these questions on
> the list.

I hit reply (Instead of replyall) Sorry,

>  As a first step I would check that there is data being
> transferred over the digital link to the CODEC, then look at the
> audio routing to ensure that the signal is routed to the output.

Thanks for suggestions..



-- 
Cheers
(: Naveen Krishna Ch :)
