From: Koblinger Egmont <egmont@uhulinux.hu>
Subject: quadra sound
Date: Tue, 19 Aug 2003 16:13:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308191610130.22686-100000@sziami.cs.bme.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

(I don't know if it's a bug in quadra, alsa or the linux kernel.)

With kernel 2.4.20 + alsa 0.9.0rc6 everything went fine.

With kernel 2.4.21 + alsa 0.9.6 all my applications keep on playing sounds except quadra (tried at least xmms, mpg123, mplayer and xblast).

Relevant part of strace quadra with 2.4.20 + alsa 0.9.0rc6:
[...]
open("/dev/dsp", O_WRONLY)              = 5
ioctl(5, SNDCTL_DSP_SETFRAGMENT, 0xbfffef5c) = 0
ioctl(5, SNDCTL_DSP_GETBLKSIZE, 0x83106cc) = 0
ioctl(5, SNDCTL_DSP_SETFMT, 0x83106c8)  = 0
ioctl(5, SOUND_PCM_READ_CHANNELS, 0x83106c0) = 0
ioctl(5, SOUND_PCM_READ_RATE, 0x83106c4) = 0
[...]
ioctl(5, SNDCTL_DSP_GETOSPACE, 0xbfffeff0) = 0
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
[...]
ioctl(5, SNDCTL_DSP_GETOSPACE, 0xbfffeff0) = 0
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
[...]

The same part of strace's output with 2.4.21 + alsa 0.9.6:
[...]
open("/dev/dsp", O_WRONLY)              = 5
ioctl(5, SNDCTL_DSP_SETFRAGMENT, 0xbfffef5c) = 0
ioctl(5, SNDCTL_DSP_GETBLKSIZE, 0x83106cc) = 0
ioctl(5, SNDCTL_DSP_SETFMT, 0x83106c8)  = 0
ioctl(5, SOUND_PCM_READ_CHANNELS, 0x83106c0) = 0
ioctl(5, SOUND_PCM_READ_RATE, 0x83106c4) = 0
[...]
ioctl(5, SNDCTL_DSP_GETOSPACE, 0xbfffeff0) = 0
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
[...]
ioctl(5, SNDCTL_DSP_GETOSPACE, 0xbfffeff0) = -1 EPIPE (Broken pipe)
[...]

and from now on all ioctl()'s on fd 5 return -1 errno==EPIPE and hence quadra doesn't even try to write() to it.

Quadra is available from the usual sourceforge location. You may need some
patches from the patches section if you use a recent version of gcc. The
bug both appears with quadra 1.1.8 and currect cvs. Current cvs is better
and easier to compile with gcc3.x.

I have an SB AWE64 (ISA) card, snd-sbawe module.

ALSA is compiled together with the kernel (as if it were modules shipped by the kernel), using Mandrake's patches for this purpose.



Any help is appreciated,

Egmont



-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
