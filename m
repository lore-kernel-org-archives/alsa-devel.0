From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Grey noise with HDA Intel PCH
Date: Thu, 14 Aug 2014 12:46:16 +0200
Message-ID: <20140814124616.65991d7e@saldaea>
References: <20140814114003.7b0019f3@saldaea>
	<53EC8D5B.5020709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F7DF2615F7
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 12:46:33 +0200 (CEST)
In-Reply-To: <53EC8D5B.5020709@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Thu, 14 Aug 2014 12:20:11 +0200
schrieb Clemens Ladisch <clemens@ladisch.de>:

> Julian Wollrath wrote:
> > when having my soundcard not muted, I get to hear grey noise over
> > the speakers or over the headphone
> >
> > Simple mixer control 'Master',0
> >   Mono: Playback 19 [22%] [-51.00dB] [on]
> 
> This is rather low.  A lower signal level implies a worse signal-to-
> noise ratio.
It is also hearable, with the volume turned up higher and when nothing
is playing.

> > Simple mixer control 'Mic',0
> >   Front Left: Playback 0 [0%] [-34.50dB] [on]
> >   Front Right: Playback 0 [0%] [-34.50dB] [on]
> 
> This plays any noise from the mic input.
Turning it off makes no difference since capture is turned off anyway:
> > Simple mixer control 'Capture',0
> >  Capabilities: cvolume cswitch
> >  Capture channels: Front Left - Front Right
> >  Limits: Capture 0 - 63
> >  Front Left: Capture 63 [100%] [30.00dB] [off]
> >  Front Right: Capture 63 [100%] [30.00dB] [off]

Cheers,
Julian
