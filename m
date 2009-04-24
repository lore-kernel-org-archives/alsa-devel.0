From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Fri, 24 Apr 2009 18:08:07 +0200
Message-ID: <20090424160807.GI10450@buzzloop.caiaq.de>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CCBDC243B3
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 18:08:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F1DE99.7050104@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 10:45:29AM -0500, Timur Tabi wrote:
> Daniel Mack wrote:
> > The control modifies the MUTE register, hence the polarity must be
> > inverted.
> 
> I have a question.  In alsamixer, the capture switch looks either like this:
> 
>                             ------
> 
>                           < Master >
> 
> or like this:
> 
> 
>                             L    R
>                             CAPTUR
> 
>                           < Master >
> 
> What exactly does this mean?  Which one is supposed to mean "muted"?

The switch's name is 'Master Capture Switch' which means to me that it
is a thing that switches the capture on and off, and hence, it should be
set to 'on' for normal operation. If it was meant to mute the input
when switched on, the name should be 'Master Caputure Mute Switch' or
something, right?

> And how come even though this switch is a SOC_DOUBLE, I cannot control
> the left and right channel independently with the < and > keys, and the
> "M" key doesn't toggle it either.

Don't know about the alsamixer tool, but with amixer, you can set the
channels individually with the following syntax:

$ amixer cset numid=8 on,off
numid=8,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,off

Daniel
