From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
 DG45FC motherboard
Date: Sun, 25 Oct 2009 23:31:45 +0100
Message-ID: <20091025223145.GA30339@hardeman.nu>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost>
	<20091020223758.GA31022@hardeman.nu>
	<20091021013812.GB7279@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20091021013812.GB7279@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, intel-gfx@lists.freedesktop.org, Lennart Poettering <mznyfn@0pointer.de>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 21, 2009 at 09:38:12AM +0800, Wu Fengguang wrote:
> On Wed, Oct 21, 2009 at 06:37:58AM +0800, David H=E4rdeman wrote:
> > On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:
> > >On Thu, Oct 15, 2009 at 01:40:53AM +0800, David H=E4rdeman wrote:
> > >> >Complete silence for how much time?
> > >> =

> > >> For the entire duration of the particular movie/audio track/video =

> > >> clip/whatever.
> > >> =

> > >
> > >I actually have a DG45FC box and have not run into this problem for
> > >all the HDMI monitors I have. What's your monitor model?
> > =

> > A Samsung LE-55A956 LCD TV. But I think the problem is not with the =

> > monitor (TV) but rather with the receiver that is between the DG45FC an=
d =

> > the TV. The receiver is a Marantz SR8002 with HDMI support.
> =

> Got it. If you have a HDMI capable TV or monitor, it would be possible to=
 get
> rid of the Marantz and check if the problem sticks :)

Nope, DG45FC <-> TV works fine (although only with stereo of course), so =

the culprit is the Marantz which is either being picky or buggy. Judging =

from from quick Google searches, HDMI related problems with audio/video =

seems par for the course with lots of different manufacturers (oh joy).

> OK. You can get more debug info if turning on
> =

> CONFIG_SND_VERBOSE_PROCFS=3Dy
> CONFIG_SND_VERBOSE_PRINTK=3Dy
> CONFIG_SND_DEBUG=3Dy
> CONFIG_SND_DEBUG_VERBOSE=3Dy
> CONFIG_SND_PCM_XRUN_DEBUG=3Dy

Enabled in my latest tests, dmesg included below...

> > >What if you change display
> > >modes with xrandr?
> > =

> > Haven't tried that yet...currently running on 1920x1080@60 which should =

> > (I guess) be one of the most common modes with modern LCD TV's.
> =

> The infoframe would be different for 2-channel pure music and 5.1 channel
> movie. The video timing might also affect audio stream, because the HDMI
> audio data is transfered in the gaps of video data.

I've tried a couple of different modes with xrandr, with both 2, 6 and 8 =

channels of audio but it doesn't seem to change anything.
 =

> > >HDMI codec/sink seem to take some time to response to the output
> > >enable and new infoframe, so there are some delay. I've moved the HDMI
> > >output enable command to module load time, this helps. The infoframe
> > >is in theory created in run time based on the format of _each_ new
> > >audio stream, so infoframe transmission has to be started/stopped
> > >for each track..
> > =

> > So my current theory is along the line of HDMI audio infoframe or video =

> > infoframe problems. Do you have any pointers where in the driver(s) =

> > the infoframes (both audio and video) are generated so that I can add =

> > some debugging statements to dump the frames and compare the working =

> > and non-working scenarios?
> =

> I guess the infoframe itself should be identical for the same clip.
> Have you tried upgrading to a recent Xorg/intel gfx driver?

Currently testing with kernel 2.6.32-rc5 (self-compiled) + intel-gfx =

2.9.0 and X11R7.4 (from Debian unstable).
 =

> Anyway, the kernel driver code is linux/sound/pci/hda/patch_intelhdmi.c
> The relevant function is hdmi_setup_audio_infoframe(). Inside which the
> hdmi_setup_channel_mapping() is not functioning for G45,
> hdmi_setup_channel_allocation() is no-op for 2-channel music.
> hdmi_debug_dip_size() and hdmi_clear_dip_buffers() can also be commented =
out.
> And feel free to ask more questions :)

I think I found a bug in the infoframe generation, =

hdmi_fill_audio_infoframe from sound/pci/hda/patch_intelhdmi.c has two =

for loops which use sizeof(ai) but ai is a pointer to struct =

hdmi_audio_infoframe so the size of a pointer is used rather than the =

size of the struct meaning that the wrong number of bytes is written.

After fixing that, the dmesg output when playing "speaker-test -c8 -twav =

-D hdmi -l1" is:

[  866.169344] ALSA sound/pci/hda/hda_intel.c:1617: azx_pcm_prepare: =

bufsize=3D0x10000, format=3D0x17
[  866.169353] ALSA sound/pci/hda/hda_codec.c:1083: =

hda_codec_setup_stream: NID=3D0x2, stream=3D0x5, channel=3D0, format=3D0x17
[  866.176112] ALSA sound/pci/hda/patch_intelhdmi.c:446: HDMI: select CA =

0x13 for 8-channel allocation:  FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC =

FLW/FRW FLH/FRH TC FCH
[  866.176321] HDMI: ASP channel 0 =3D> slot 0
[  866.176354] HDMI: ASP channel 0 =3D> slot 0
[  866.176406] HDMI: ASP channel 0 =3D> slot 0
[  866.176438] HDMI: ASP channel 0 =3D> slot 0
[  866.176490] HDMI: ASP channel 0 =3D> slot 0
[  866.176533] HDMI: ASP channel 0 =3D> slot 0
[  866.176565] HDMI: ASP channel 0 =3D> slot 0
[  866.176617] HDMI: ASP channel 0 =3D> slot 0
[  866.176649] HDMI: ELD buf size is 64
[  866.176691] HDMI: DIP GP[0] buf size is 13
[  866.176733] HDMI: DIP GP[1] buf size is 10
[  866.176775] HDMI: DIP GP[2] buf size is 30
[  866.176817] HDMI: DIP GP[3] buf size is 30
[  866.176859] HDMI: DIP GP[4] buf size is 0
[  866.176901] HDMI: DIP GP[5] buf size is 0
[  866.176943] HDMI: DIP GP[6] buf size is 0
[  866.176986] HDMI: DIP GP[7] buf size is 0
[  866.179041] ALSA sound/pci/hda/patch_intelhdmi.c:342: HDMI: DIP GP[0] =

buf reported size=3D13, written=3D32
[  866.181209] ALSA sound/pci/hda/patch_intelhdmi.c:342: HDMI: DIP GP[1] =

buf reported size=3D10, written=3D32
[  866.183271] ALSA sound/pci/hda/patch_intelhdmi.c:342: HDMI: DIP GP[2] =

buf reported size=3D30, written=3D32
[  866.185385] ALSA sound/pci/hda/patch_intelhdmi.c:342: HDMI: DIP GP[3] =

buf reported size=3D30, written=3D32
[  866.185574] XXX: Writing audio inf: 0x84 0x01 0x0A 0x57 0x07 0x00 =

0x00 0x13 0x00 0x00 0x00 0x00 0x00 0x00
[  872.032225] ALSA sound/pci/hda/hda_codec.c:1096: =

hda_codec_cleanup_stream: NID=3D0x2

(The XXX line was added by me to print the audio infoframe)

I think (if I understood the code correctly), that "DIP GP[0]" holds the =

infoframe, but I don't understand why it would report a buf size of =

13...the audio infoframe is 14 bytes (3 header + 1 checksum + 10 body)?

Also, what does the GP[1..3] buffers hold?

Anyway, even with the above for loops fixed, I still have the same =

problems (not that weird perhaps since all the bytes that were being =

missed anyway defaulted to 0x00).

I've noticed that if a run this:

	while true; do
		speaker-test -t wav -c 8 -D hdmi -l 1
		speaker-test -t wav -c 2 -D hdmi -l 1
	done

it always works, but this:

	while true; do
		speaker-test -t wav -c 2 -D hdmi -l 1
	done

doesn't.

Not sure what to make of it, the intel hdmi driver doesn't seem to do =

anything special if the parameters (like channel count) change between =

clips.

-- =

David H=E4rdeman

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
