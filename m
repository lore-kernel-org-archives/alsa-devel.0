From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Edirol DA-2496
Date: Fri, 10 Oct 2003 18:43:17 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310101826210.12877-100000@studcom.urz.uni-halle.de>
References: <1065725439.2728.136.camel@turandot>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1065725439.2728.136.camel@turandot>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonatan de la Torre <jonatandelatorre@ono.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Jaroslav, Takashi, any comments on this?

Jonatan de la Torre wrote:
> El vie, 19-09-2003 a las 10:27, Clemens Ladisch escribi=F3:
> > Jonatan de la Torre wrote:
> > > * One IC whose PCB tag is IC38
> > >
> > > CS8420-CS
> >
> > sample rate converter
> >
> > > * Four IC's whose PCB tags are IC17, IC22, IC27, IC32
> > >
> > > AK4524VF
> >
> > stereo 24bit 96kHz DAC/ADC
> >
> > These chips are used on M-Audio cards, too.
> >
> > > Anything else before I close the box?
> >
> > Please try to load the snd-ice1712 driver, and show the contents =
of
> > the /proc/asound/cardX/ice1712 file. The driver might actually wo=
rk
> > with your card.
> >
> > If not, the EEPROM subvendor/device ID has to be added to the dri=
ver.
> > Your card looks as if it might be compatible to the Delta 1010LT;=
 if
> > it isn't, we have to know to which pins of the ICE1712 the other =
chips
> > are connected.
> >
> Hi Clemens and people, here I am again, this is the contents of
> /proc/asound/card0/ice1712
> ICEnsemble ICE1712 at 0xd400, irq 15
>
> EEPROM:
>   Subvendor        : 0xce164010

This isn't one of the known IDs.

>   Size             : 29 bytes
>   Version          : 1
>   Codec            : 0x1f
>   ACLink           : 0x80
>   I2S ID           : 0x71
>   S/PDIF           : 0x0
>   GPIO mask        : 0xfc
>   GPIO state       : 0x2
>   GPIO direction   : 0x3
>   AC'97 main       : 0x0
>   AC'97 pcm        : 0x0
>   AC'97 record     : 0x0
>   AC'97 record src : 0x44
>   DAC ID #0        : 0x7
>   DAC ID #1        : 0x7
>   DAC ID #2        : 0x7
>   DAC ID #3        : 0x7
>   ADC ID #0        : 0x7
>   ADC ID #1        : 0x7
>   ADC ID #2        : 0x7
>   ADC ID #3        : 0x7
>   Extra #28        : 0x0
>
> Registers:
>   PSDOUT03         : 0x0000
>   CAPTURE          : 0x00000000
>   SPDOUT           : 0x800f
>   RATE             : 0x08
>
> The driver almost works but how can I know wich one ? I think that =
only
> OSS driver works but ALSA not.

There is no OSS driver AFAIK, and the OSS emulation uses the ALSA
driver.

> Maybe the owner manual helps you. I can send the pdf file

It won't help unless it shows how the chips are wired.

> How do I do to know the conections? I follow the tracks on the boar=
d?

Yes, preferably with a multimeter. I think the interesting connection=
s
are only those going though the connecting cable.


Regards,
Clemens





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
