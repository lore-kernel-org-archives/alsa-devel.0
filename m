From: "Gary E. Miller" <gem@rellim.com>
Subject: Re: ICH5 fails
Date: Tue, 3 May 2005 12:22:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0505031211120.16693@catbert.rellim.com>
References: <Pine.HPX.4.33n.0505031455320.19889-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0505031455320.19889-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yo Clemens!

Thank you for taking the time to look at my problem!

On Tue, 3 May 2005, Clemens Ladisch wrote:

> Gary E. Miller wrote:
> > I have laptops and desktops with the ICH5 sound subsystem.  They
> > all work fine up to 2.6.8.1.  Anything past that does not work.
>
> What does "does not work" mean?  No sound?

- From my previous post you can see that the Intel audio chip does not
even show up in /proc/asound/cards, so that is a show stopper right there.
When it works I get to ALSA cards, one for the modem and one for the
sound chip.  When it does not work I get an "unkown codec" for the modem
and nothing for the sound chip.  Not a simple muting problem or some such.

> > kernel: ALSA device list:
> > kernel:  #0: Intel ICH5 with unknown codec at 0xd0000c0 0, irq 17
>
> Please try ALSA 1.0.9rc3.

Hmm, slightly better.  At leaast there is some logging as to why the
sound chip is not being found.  Here is my dmesg:

ALSA /mnt/hobbes/u3/local/src/ALSA/alsa-driver-1.0.9rc3/pci/../alsa-kernel/pci/intel8x0m.c:978: Unable to initialize codec #0
Intel ICH Modem: probe of 0000:00:1f.6 failed with error -13
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c
ALSA /usr/local/src/ALSA/alsa-driver-1.0.9rc3/pci/intel8x0.c:615: codec_read 0: semaphore is not ready for register 0x2c


> What are the contents of /proc/asound/card0/codec97#0/ac97#0-0?

# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 30

Revision         : 0xff
Compat. Class    : 0x1f
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -reserved1- -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : on
3D enhancement   : on
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : on
Extended ID      : codec=3 rev=3 AMAP LDAC SDAC CDAC DSA=3 VRM SPDIF DRA VRA
Extended status  : PRL PRK PRJ PRI SPCV MADC LDAC SDAC CDAC SPDIF=10/11 VRM SPDIF DRA VRA
PCM front DAC    : 65535Hz
PCM Surr DAC     : 65535Hz
PCM LFE DAC      : 65535Hz
PCM ADC          : 65535Hz
PCM MIC ADC      : 65535Hz
SPDIF Control    : PRO Non-audio Preemph50/15 Category=0x7f Generation=1 Rate=32kHz DRS Validity

                    Gain     Inverted  Buffer delay  Location
Master Out       : -10.5 dBV    X      31/fs         NC/unused
AUX Out          : -10.5 dBV    X      31/fs         NC/unused
Center/LFE Out   : -10.5 dBV    X      31/fs         NC/unused
SPDIF Out        : -10.5 dBV    X      31/fs         NC/unused
Phone In         : -10.5 dBV    X      31/fs         NC/unused
Mic 1            : -10.5 dBV    X      31/fs         NC/unused
Mic 2            : -10.5 dBV    X      31/fs         NC/unused
Line In          : -10.5 dBV    X      31/fs         NC/unused
CD In            : -10.5 dBV    X      31/fs         NC/unused
Video In         : -10.5 dBV    X      31/fs         NC/unused
Aux In           : -10.5 dBV    X      31/fs         NC/unused
Mono Out         : -10.5 dBV    X      31/fs         NC/unused
Extended modem ID: codec=3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz
#

Someone suggested that I add inte8x0m to /etc/hotplug/blacklist, that had
no effect, the intel8x0m module still loaded.  So I deleted that module so
only the sound would be loaded, same results.

RGDS
GARY
- ---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Blvd, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCd89z8KZibdeR3qURAoBmAJ9ZEUL1YdqD3BobSLRsjZ/G8tS+lQCfRtf4
4cfSMVnhsRtmLCYNyzDvLIc=
=tk2C
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
