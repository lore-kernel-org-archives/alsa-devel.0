From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs (works!)
Date: Tue, 17 Sep 2002 17:08:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209180008.RAA06607@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0209130956340.647-100000@pnote.perex-int.cz>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209130956340.647-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > I'm using 2.4.20-pre4 + lowlat + preempt + capabilities + acpi
> > > (I think that's all)
> > >
> > > > anyway, i changed the relevant part on cvs.  please try once to
> > > > update.
> > >
> > > I'll try again...
> >
> > Compiles fine and seems to be working ok (intel8x0). I don't
> > know what the situation was before because I did not look at
> > it, but now there are two ac97 codecs recognized (I guess the
> > second one corresponds to the modem - I'll have to find time
> > to test the modem so verify it works). There is no delay in
> > recognizing them as far as I can tell.
>
> Note that modem codecs are only detected. You might send me contents of
> /proc/asound/card0/intel8x0 and ac97* files to verify, if everything is
> ok.

I almost forgot about this:

/proc/asound/card0/intel8x0:
Intel8x0

Global control        : 0x00000002
Global status         : 0x00300300
AC'97 codecs ready    : primary secondary

/proc/asound/card0/ac97#0:
0-0/0: Yamaha YMF753

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF
Extended status  : SPCV SPDIF=3/4
SPDIF Control    : Consumer PCM Category=0x0 Generation=0 Rate=48kHz

/proc/asound/card0/ac97#1-1
1-1/0: Conexant (21)

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended modem ID: codec=1  CID1 LIN1

-- Fernando


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
