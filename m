From: Josh Green <josh@resonance.org>
Subject: Intel Azalia problems
Date: Wed, 13 Apr 2005 05:07:07 -0700
Message-ID: <1113394027.16526.3.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I recently purchased a new laptop which has an Intel Azalia sound
interface.  I noticed that this is a pretty recent addition to the ALSA
drivers.  Although it seems to be basically working, I'm having a couple
problems.

The first problem has to do with the headphone jack, which on this
laptop is an SPDIF/output combo jack. I can hear output on the built in
speakers (after un-muting and turning up the "Front" level), but when I
plug in headphones I don't hear anything (despite the fact that the
"Headphone" mixer is turned up and unmuted).

The other problem is with certain applications which use oss.  Quake3
for example prints the following in the terminal it is started from:

------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

An strace reveals this, which may or may not be helpful.

[pid 15829] open("/dev/dsp", O_RDWR)    = 20
[pid 15829] getuid32()                  = 501
[pid 15829] setresuid32(-1, 501, -1)    = 0
[pid 15829] ioctl(20, SNDCTL_DSP_GETCAPS, 0xbffff574) = 0
[pid 15829] ioctl(20, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE,
0x81776ac) = 0
[pid 15829] ioctl(20, SNDCTL_DSP_STEREO, 0xbffff56c) = 0
[pid 15829] ioctl(20, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE,
0x88446b4) = 0
[pid 15829] ioctl(20, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS,
0xbffff568) = 0
[pid 15829] ioctl(20, SNDCTL_DSP_GETOSPACE, 0xbffff580) = 0
[pid 15829] mmap2(NULL, 32768, PROT_READ|PROT_WRITE, MAP_SHARED, 20, 0)
= -1 EIO (Input/output error)
[pid 15829] write(2, "Could not mmap dma buffer PROT_W"..., 47Could not
mmap dma buffer PROT_WRITE|PROT_READ
) = 47
[pid 15829] write(2, "trying mmap PROT_WRITE (with ass"..., 86trying
mmap PROT_WRITE (with associated better compatibility / less performance
code)

Other OSS programs (such as "play") work fine, so perhaps its just
programs that try and MMAP the device.

I copied the file /usr/share/alsa/cards/Azalia.conf to /etc/asound.conf,
but with the same results.  Despite the low volume output of the
internal speakers, I can hear clicks in the output with mplayer and
totem (perhaps a sampling rate issue?)

Here is some info about my system:
alsa-driver 1.0.9rc2
alsa-lib 1.0.9rc2
alsa-utils 1.0.8
kernel 2.6.7-gentoo-r11
NVidia GeForce Go 6600 (I'm using the commercial drivers)

ALSA modules loaded:

snd_hda_intel          16496  2
snd_hda_codec          59008  1 snd_hda_intel
snd_seq_oss            36480  0
snd_seq_midi_event      8064  1 snd_seq_oss
snd_seq                53392  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          8972  2 snd_seq_oss,snd_seq
snd_pcm_oss            52008  0
snd_pcm                92680  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              25604  2 snd_seq,snd_pcm
snd_page_alloc         10120  2 snd_hda_intel,snd_pcm
snd_mixer_oss          20096  2 snd_pcm_oss
snd                    54884  13
snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               9952  2 snd


I would appreciate any info on using this card with ALSA.  Also, it
seems my modem is tied into this card as well (HDAUDIO soft modem), any
idea if this is supported or if there are plans to?  Cheers!
Josh Green




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
