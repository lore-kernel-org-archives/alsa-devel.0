From: Mark Knecht <markknecht@comcast.net>
Subject: Re: VT8233/A/8235 Clock Problem - good results, some
	possible bugs?
Date: Tue, 09 Dec 2003 05:27:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070976470.1854.10.camel@Wizard.knechthome.com>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
	 <1070914615.1921.24.camel@Wizard.knechthome.com>
	 <20031208210455.GF1802@sirius.home>
	 <1070942917.1981.67.camel@Wizard.knechthome.com>
	 <20031209102125.GB835@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mf3fnJ+9Z9pVc88SSvqE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031209102125.GB835@master.mivlgu.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-mf3fnJ+9Z9pVc88SSvqE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-12-09 at 02:21, Sergey Vlasov wrote:
> On Mon, Dec 08, 2003 at 08:08:37PM -0800, Mark Knecht wrote:
> > On Mon, 2003-12-08 at 13:04, Sergey Vlasov wrote:
> > 
> > > Most likely you need the dxs_support option instead of ac97_clock.
> > > 
> > > With dxs_support=2 the sound should work fine, but the hardware mixing
> > > capability will be disabled.  Then you can try dxs_support=1 or
> > > dxs_support=4.
> > > 
> > > By default snd-via82xx uses dxs_support=3 (except for certain known
> > > motherboards), this makes only 48000 sampling rate available.  The
> > > ALSA library can perform resampling for ALSA apps, and the kernel OSS
> > > emulation layer can do resampling for OSS apps, but the quality is
> > > often not good.
> > 
> > Sergey,
> >    Thanks for sending me down this path. Definitely I'm getting better
> > results now. I did find some things out though. Some may possibly be
> > bugs:
> > 
> > 1) On my system dxs_support=3 is NOT the same as not setting dxs_support
> > at all. With dxs_support not set I get horrible results. With
> > dxs_support=3 I get reasonable to good results.
> 
> This means that you board in known to the driver...
> 
> There is an entry for a similar model in the driver:
> 
> 	{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */
> 
> The IDs checked here are the PCI subsystem vendor/device ID of the sound
> device.  Run "lspci -v" and find "Multimedia audio controller" in the
> output, then look at the "Subsystem:" line.  The vendor ID will probably
> be replaced by the corresponding name; you can find out the number by
> executing a command like "lspci -nv -s 00:07.5" (use the slot number for
> your audio controller which is shown in the lspci output).
> 
> > 2) **ALL** applications I tried (alspalayer, gxine & xmms) are
> > overdriving the audio path somewhere and causing distortion. The output
> > level from the motherboard is not hot. In fact, even when the apps are
> > up full the output level is actually down about 12-15db from where I'd
> > like it, but I'm getting lots of distortion. When I reduce alsaplayer's
> > level the distortion mostly goes away, although I'm left with
> > considerable background hiss. In all cases I monitored the return level
> > and it never causes my inputs to clip. (This level difference may be a
> > pro equipment/consumer equipment issue.)
> > 
> > 3) With dxs_support=1 I get very bad sounding results. It appears that
> > there is a bug in the ADC setting. PCM ADC is set to 48K. I think this
> > is the mode I would really like to use if PCM ADC was set to 44.1K, but
> > as it is it sounds terrible. dxs=2 is not very good, and dxs=3/4 are
> > both pretty good. All modes have a lot of hiss compared to my HDP 9652
> > and outboard D/A. (Expected...)
> > 
> > 
> > cat /proc/asound/card0/codec97#0/ac97#0-0
> > 
> > 		   dxs=1	dxs=2		dxs=3/4
> > <SNIP>
> > PCM front DAC    : 44100Hz	22050Hz		48000Hz
> > PCM Surr DAC     : 44100Hz	22050Hz		48000Hz
> > PCM LFE DAC      : 44100Hz	22050Hz		48000Hz
> > PCM ADC          : 48000Hz	22050Hz		48000Hz
> > SPDIF Control    : 44.1kHz	44.1kHz		48000Hz
> > 
> > Sound Quality:	   BAD!!	not good	Good
> > 
> > So, I am currently using Mode 4 and getting pretty good results,
> > although I think Mode 1 would be even better for me if the PCM ADC was
> > set to the right value.
> 
> Something strange is going on here...
> 
> With dxs_support=1, the PCM DAC frequencies are set to match the mode
> requested by the software.  Probably the VRA support in the onboard codec
> is not very good.
> 
> Please show the complete contents of
> /proc/asound/card0/codec97#0/ac97#0-0.

The attached file has the output you asked for for all 5 possibilities,
none, 0,1,2,3. However, the 'none' setting was actually

option snd-via82xx dxs_support

with no number following, instead of no option statement at all. The
sound was the same bad sound, so I think this was probably not an issue.

I am disappointed that there is no option to set the PCM ADC to 44100 in
dxs_support=1. Is that something that could be changed in a future rev,
as in dxs_support=5 ? Since I work 100% of the time in 44100 it would
seem that this is requiring me to resample.

Thanks,
Mark



--=-mf3fnJ+9Z9pVc88SSvqE
Content-Disposition: attachment; filename=dxs_support.txt
Content-Type: text/plain; name=dxs_support.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

dxs_support=not set at all


Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
Wizard root # 


dxs_support=1


Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
SPDIF In Status  : Not Locked
Wizard root # 


dxs_support=2

Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=res VRA
PCM front DAC    : 22050Hz
PCM Surr DAC     : 22050Hz
PCM LFE DAC      : 22050Hz
PCM ADC          : 22050Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
SPDIF In Status  : Not Locked
Wizard root # 


dxs_support=4


Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
Wizard root # 


dxs_support=4


Wizard root # !cat
cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked
Wizard root # 


--=-mf3fnJ+9Z9pVc88SSvqE--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
