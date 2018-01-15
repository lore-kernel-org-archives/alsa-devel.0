From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Maximum 50 dB gain in ALSA softvol plugin
Date: Mon, 15 Jan 2018 15:32:13 +0100
Message-ID: <alpine.DEB.2.11.1801151520280.2359@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1801121645540.16471@lnxricardw1.se.axis.com>
 <s5ha7xj3ug4.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151410060.2359@lnxricardw1.se.axis.com>
 <s5hd12b2q99.wl-tiwai@suse.de>
 <alpine.DEB.2.11.1801151446420.2359@lnxricardw1.se.axis.com>
 <s5h8tcz2pje.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C1D7B267515
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:32:21 +0100 (CET)
In-Reply-To: <s5h8tcz2pje.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Mon, 15 Jan 2018, Takashi Iwai wrote:

> > The usecase we have actually calls for 55 dB of gain maximum, but I was =

> > thinking that looking at the code the maths can actually handle 90 dB s=
o =

> > it would be good 'reasonable limit' - it's a nice round number and fits=
 in =

> > 16 bits (signed).
> > =

> > The usecase we have is using digital MEMS microphones ((2S connected, =

> > with no integral amplification) and when the sound source is far away, =
a =

> > fair amount of gain can be needed.
> =

> But why do you need 90dB?  "Because it can" is no good reason to
> increase such a safe limit.

No, I don't need 90 dB. The specific usecase I have calls for 55 dB, so I =

could of course just change the maximum from 50 to 55 dB. Or perhaps with =

a bit of margin, such as 60 dB or 70 dB.

They way I see it though, softvol is just an amplifier component. It's up =

to the user to use it for whatever purpose they want. And there is no =

inharent danger in allowing large gains, as the signal will just clip at =

full scale, it's not like having a power amplifier with infinite power =

resources. So the upper limit should be bound by something technical, like =

an internal processing stage overflowing, which is why I suggested 90 dB, =

as it is at slightly more than 90 dB that a 16 bit signed short overflows, =

16-bit shorts being part of the current set of calculations in the =

MULTI_DIV_ macros. So 90 dB seemed to me a limit that is related to the =

technical limitations of the algorithm employed.

Note that I'm not suggesting changing the default gain range which I =

believe is -50 to 0 dB. In order to utilize the large gain, someone must =

purposefully enter a 'max_dB' value in /etc/asound.conf and then set the =

gain to that value, so there would seem little risk of setting a large =

gain by mistake.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
