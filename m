From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: [alsa-devel] em8300 and ALSA problems
Date: Fri, 8 Feb 2008 01:27:05 +0100
Message-ID: <20080208002704.GC6545@tryphon.debian.net>
References: <47A7300D.3010907@willies.info> <s5h4pco3f56.wl%tiwai@suse.de>
	<47A73364.9060409@willies.info> <s5hzlug1zyi.wl%tiwai@suse.de>
	<47A736F9.9010507@willies.info>
Reply-To: dxr3-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dxr3-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <47A736F9.9010507@willies.info>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dxr3-devel>,
	<mailto:dxr3-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dxr3-devel>
List-Post: <mailto:dxr3-devel@lists.sourceforge.net>
List-Help: <mailto:dxr3-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dxr3-devel>,
	<mailto:dxr3-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: dxr3-devel-bounces@lists.sourceforge.net
Errors-To: dxr3-devel-bounces@lists.sourceforge.net
To: Jan Willies <jan@willies.info>
Cc: dxr3-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all, and sorry for the late answer,

On Mon, Feb 04, 2008 at 05:02:01PM +0100, Jan Willies wrote:
> Takashi Iwai wrote:
> > At Mon, 04 Feb 2008 16:46:44 +0100,
> > Jan Willies wrote:
> >> Takashi Iwai wrote:
> >>> At Mon, 04 Feb 2008 16:32:29 +0100,
> >>> Jan Willies wrote:
> >>>> [root@server ~]# alsaplayer --verbose -o alsa -d hw:1,0 Strong.mp3 =

> >>>> AlsaPlayer 0.99.80
> >>>> (C) 1999-2004 Andy Lo A Foe <andy@alsaplayer.org> and others.
> >>>> Output plugin: ALSA output v1.9.0beta12
> >>>> error on set_format SND_PCM_FORMAT_S16
> >>>> Unavailable hw params:
> >>>> ACCESS:  RW_INTERLEAVED
> >>>> FORMAT:  S16_BE
> >>> The device is supposed to be big-endian only.  Try plughw:1,0
> >>> instead to convert endianness.
> >> Yes, that seems to work! Only for analog output though. When I try wit=
h digital I get the same error again.
> >>
> >> [jan@server ~]$ cat /proc/asound/devices =

> >>   0: [ 0]   : control
> >>   1:        : sequencer
> >>  16: [ 0- 0]: digital audio playback
> >>  24: [ 0- 0]: digital audio capture
> >>  25: [ 0- 1]: digital audio capture
> >>  32: [ 1]   : control
> >>  33:        : timer
> >>  48: [ 1- 0]: digital audio playback
> >>  49: [ 1- 1]: digital audio playback
> >>
> >> [root@server ~]# alsaplayer --verbose -o alsa -d plughw:1,1 Strong.mp3 =

> >> AlsaPlayer 0.99.80
> >> (C) 1999-2004 Andy Lo A Foe <andy@alsaplayer.org> and others.
> >> Output plugin: ALSA output v1.9.0beta12
> >> error on set_format SND_PCM_FORMAT_S16
> >> Unavailable hw params:
> >> ACCESS:  RW_INTERLEAVED
> >> FORMAT:  IEC958_SUBFRAME_BE
> >> [...]
> > =

> > The plug plugin doesn't handle the automatic conversion of
> > IEC958-subframe formats.  You'll likely need to create a PCM
> > configuration to use iec958 plugin properly (better as a card-specific
> > config stored in /usr/share/alsa/cards).  Some config files there
> > already use iec958 plugin, such as ATIIXP-SPDMA.conf.
> =

> There is already a /usr/share/alsa/cards/EM8300.conf with EM8300.pcm.iec9=
58.0 {...} (http://pastebin.ca/raw/891351) from Ville Skytt=E4 but I don't =
know how to use it. Neither how to create a PCM configuration for the iec95=
8 plugin. I guess I'll wait for some dxr3 devs to join the party :-)

As Takashi Iwai noticed, the "EM8300 DAC" device only supports 16-bit =

big-endian 2-channel data, but it also has its channels swapped and =

lacks a volume control. Using plughw:1,0 does not unswap the channels or =

add a volume control.

As for the "EM8300 IEC958" device, it only supports big-endian =

IEC958 subframes, and needs specific values for its preambles.

For those reasons, I had to write a specific configuration file for =

EM8300 card (and fix some bugs in alsa-lib's iec958 plugin).

Using this file is pretty trivial:
  - for the "EM8300 DAC" device, use the "default:1" alsa device
  - for the "EM8300 IEC958" device, use the "iec958:1" alsa device

Not that, if I understand ALSA correctly, this is not EM8300-specifica =

at all, the same syntax should work with any card.

If you wish to add volume control and format conversion to your "EM8300 =

IEC958" device, create a ~/.asoundrc file with:

pcm.foobar {
        type plug
        slave.pcm {
                type softvol
                slave.pcm iec958:EM8300
                control {
                        name "IEC958 Playback Volume"
                        card EM8300
                }
        }
}

and then use the "foobar" alsa device. (Note that there might be some =

syntax errors, since it is untested.)

Note that there's nothing specific to the EM8300 cards here, the same =

thing should work with any card that supports IEC958, just replace the =

two "EM8300" with the name or number of the card you want to use.


Hope this helps,

Nicolas

PS: any comment or suggestion for improvement is welcome, especially =

from ALSA experts (which I am not).

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
