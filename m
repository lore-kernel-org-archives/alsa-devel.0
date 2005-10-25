From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Re: CMedia 8738 - problems running Jack
Date: Mon, 24 Oct 2005 19:09:06 -0700
Message-ID: <5bdc1c8b0510241909j6dc178e8xfaa33c0692bed907@mail.gmail.com>
References: <5bdc1c8b0510240924w10e1a8d1o499e3739fd8e1923@mail.gmail.com>
	 <5bdc1c8b0510240932o6566fef2q96f1f2a5a970b771@mail.gmail.com>
	 <20051024202157.GA11137@meep>
	 <5bdc1c8b0510241455s1aaf8940gc408902fe06af8f@mail.gmail.com>
	 <20051024223838.GA25313@meep> <1130193988.23853.69.camel@mindpipe>
	 <20051025002420.GB11137@meep>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051025002420.GB11137@meep>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Cunningham <spark@xdev.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/24/05, Dave Cunningham <spark@xdev.net> wrote:
> On Mon, Oct 24, 2005 at 06:46:27PM -0400, Lee Revell wrote:
> >On Mon, 2005-10-24 at 23:38 +0100, Dave Cunningham wrote:
> >> It's also pretty confusing why sometimes there are several
> >> stereo pcm devices to access different channels, and sometimes a
> >> single pcm device with multiple alsa "channels".  Especially
> >> since this confusion is presented to the user.
> >>
> >
> >It's not confusing at all, it makes perfect sense.  If you want to play
> >stereo out the front speakers use the "front" device.  If you want to
> >play stereo out the rear speakers use the "rear" device.  Etc.  If you
> >want to play 5.1 surround out of all 6 speakers use the "surround51"
> >device.
> >
> >What could be simpler?
> >
> >Lee
>
> It would be great if it were like that, but this is how it
> appears to me:
>
> name: C-Media PCI DAC/ADC
>
> has 6 channels, only 2 of which seem to work, whereas
>
> name: C-Media PCI 2nd DAC
>
> seems to have 2 channels.
>
> There is another device for IEC958 as well, and there is also a
> bunch of mixer controls relating to "four channel mode" and "mic
> as rear" etc.  It's *very* confusing.
>
> The card is 5.1 and has 3 analogue output jacks, and a pair of
> optical ports around the back.
>
>

In my case it's a sound chip on an older Asus A7V-266E Motherboard

http://www.mbreview.com/a7v266e.php

The link above says it's a 6-channel sound solution but on my system I
have only a stereo output. I'm guessing that there might have been a
dongle card to get the other outputs out but I've long since lost that
I suppose.

Anyway, after getting some cables this afternoon it appears that on my
system only the left output is working at all, and then it's only
working under Jack. I get no sound (so far) trying to run aplay or
alsaplayer targeted at this device, but I may be doing something wrong
there.

Before you jump at the 'only hte left side' item, the only reason I
even turned this device on after all these years of not using it was
because someone on the PlanetCCRMA list was lookign for help. He also
only gets sound on the left side, so this looks semi-real to me.

Can someone check out and let me know how to run aplay to card #2?

gigastudio ~ # cat /proc/asound/cards
0 [M2496          ]: ICE1712 - M Audio Audiophile 24/96
                     M Audio Audiophile 24/96 at 0xa400, irq 10
1 [R15            ]: RME9636 - RME Digi9636 (Rev 1.5)
                     RME Digi9636 (Rev 1.5) at 0xe2000000, irq 9
2 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                     C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 11
gigastudio ~ #

It appears that Dave gets at least stereo from his card. Is this true?
We're not in such (relatively) good shape.

Cheers,
Mark


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
