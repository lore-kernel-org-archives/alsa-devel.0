From: Dan Aloni <da-x@colinux.org>
Subject: Re: Re: ALC658 rev 0 - a problem with Rear Right
Date: Mon, 7 Mar 2005 18:57:02 +0200
Message-ID: <20050307165653.GA22454@localdomain>
References: <20050307122800.GA27123@localdomain> <Pine.HPX.4.33n.0503071406300.27740-100000@studcom.urz.uni-halle.de> <20050307153921.GA14807@localdomain> <s5h8y4zwh3f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8y4zwh3f.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2005 at 05:33:56PM +0100, Takashi Iwai wrote:
> At Mon, 7 Mar 2005 17:39:21 +0200,
> Dan Aloni wrote:
> > 
> > On Mon, Mar 07, 2005 at 02:10:14PM +0100, Clemens Ladisch wrote:
> > > Dan Aloni wrote:
> > > > The problem was introduced in the following changeset, which
> > > > was supposed to cleanup things but accidently broke something.
> > > >
> > > > "[ALSA] Clean up and fix stereo mutes" :
> > > 
> > > Most AC'97 codecs have one mute bit for both channels, but some can
> > > have one for each channel (that's called "stereo mute").
> > > 
> > > It seems the new driver enables the stereo mute bits, but then forgets
> > > to unmute the second channel.
> > > 
> > > Does anything happen if you toggle both mute bits in alsamixer?
> > 
> > Using alsamixer I am unable to mute any channel by itself - it 
> > always mutes or unmutes boths channels at the same time (I tried
> > any possible combination of m M, < or >). However if I revert the
> > changeset I am able to control each channel alone using < or > and
> > there's no problem.
> 
> Hmm, are you sure that it's ALC658?  AFAIK, the codec doesn't  support
> the stereo mutes (at least ALSA code doesn't enable it).

Unless the driver misidentifies the chipset, this is ALC658.

More info:

cat /proc/asound/cards

0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC658 at 0xfc101000, irq 201

cat /proc/asound/card0/intel8x0

Intel8x0

Global control        : 0xc0200002
Global status         : 0x10700000
SDM                   : 0x0000002a
AC'97 codecs ready    : tertiary
AC'97 codecs SDIN     : 2 0 0

cat /proc/asound/pcm

00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1


cat /proc/asound/card0/codec97\#0/ac97\#0-0 

0-0/0: Realtek ALC658 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x8086
Subsys. ID       : 0x1234

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
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
Double rate slots: 7/8
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=10/11 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1 Rate=48kHz

cat /proc/asound/card0/codec97\#0/ac97\#0-0+regs 
0:00 = 0180
0:02 = 1010
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 831f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 1313
0:1a = 0000
0:1c = 0000
0:1e = 8000
0:20 = 0400
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 09c7
0:2a = 05f1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = bb80
0:36 = 110e
0:38 = 1212
0:3a = 2a20
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0aea
0:6a = 8600
0:6c = 3601
0:6e = 0002
0:70 = 0008
0:72 = 0000
0:74 = 0105
0:76 = 0000
0:78 = 0007
0:7a = 50b0
0:7c = 414c
0:7e = 4780

-- 
Dan Aloni
da-x@colinux.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
