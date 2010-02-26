From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 26 Feb 2010 11:17:01 +0800
Message-ID: <4f3252891002251917j481c5b04o13027c0fb083f93b@mail.gmail.com>
References: <4B7A5268.5050704@ladisch.de>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D0F29103800
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 04:17:02 +0100 (CET)
Received: by pwi9 with SMTP id 9so5507123pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 19:17:01 -0800 (PST)
In-Reply-To: <20100216235658.GA6766@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/17 Lennart Poettering <mznyfn@0pointer.de>

>
>
> Nah. I actually don't need this value for PulseAudio. In PulseAudio I
> chose to shift all scales so that maximum amplification becomes 0 dB,
> so that the UIs are similar to how most hifi racks do it, and which I
> think is a nice, easy and understandable logic. That way my volume
> scales range from -inf dB to 0 dB in all cases, regardless of the
> hardware/drivers in use. Of course, that means that ALSA's own 0dB is
> not directly visible on the scale. Because it might be sometimes
> useful to know where it is, we export that position as "base volume"
> and the UIs show it with a little marker at the side.
>

For AC97 Record gain registers 1ch

-inf dB to 22.5 dB

The default value is 0x8000 which is correspond to 0dB gain when mute on

Not sure your way of shifting all scales so that maximum amplification
becomes 0 dB has any effect on the calculation since there is 22.5dB gain
when you recording by all AC97 codec



> The reason I was asking how Jaroslav chose the 0dB position for his
> measurements was purely because I wanted to do my own measurements for
> that Aureon card. The dbmeasure tool I wrote for stuff like that puts
> 0dB at max amplification, however Jaroslav didn't, so I was wondering
> how he chose 0dB then.
>
> Lennart
>
> --
>
>
