From: Josh Green <josh@resonance.org>
Subject: Re: Intel Azalia problems (some progress)
Date: Fri, 15 Apr 2005 15:15:15 -0700
Message-ID: <1113603315.29903.13.camel@SillyPuddy.localdomain>
References: <1113394027.16526.3.camel@SillyPuddy.localdomain>
	 <s5hll7mg30n.wl@alsa2.suse.de>
	 <1113567180.7140.17.camel@SillyPuddy.localdomain>
	 <s5h4qe8dxfj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qe8dxfj.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-04-15 at 14:41 +0200, Takashi Iwai wrote:
> > Still clicking in output, seemingly even with 48KHz audio, still
> > investigating.  Also many programs lock up at the end of the audio
> > output (like Rhythmbox when a song is finished for instance).
> 
> This is an unknown problem, so far.
> We got a similar problem but it was solved by setting TCREG bits 0-2.
> Possibly a similar mis-configuration by broken BIOS.
> 

An additional note about the clicking.  It seems that some programs work
fine and others don't.  XMMS using OSS API will play 48KHz or 44KHz
files without clicks, while sox play command will click with 44KHz but
works fine with 48KHz.

I think the difference may be that XMMS mmaps the device while sox does
not, here is some strace output from the two programs:

XMMS (works fine with both 44.1 or 48KHz)

[pid 30072] open("/dev/sound/dsp", O_WRONLY) = 9
[pid 30072] ioctl(9, SNDCTL_DSP_RESET, 0) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_SETFRAGMENT, 0xbffff1dc) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xb7280428) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xb7280428) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_STEREO, 0xbffff1d8) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0xb728042c) = 0
[pid 30072] ioctl(9, SNDCTL_DSP_GETBLKSIZE, 0xb7280400) = 0
[pid 30072] select(10, NULL, [9], NULL, {0, 50000}) = 1 (out [9], left {0, 50000})
[pid 30072] sched_getscheduler(0)       = 0
[pid 30072] mmap2(NULL, 667648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb642c000
[pid 30072] mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb5c2b000

Sox (clicks with 44.1KHz, fine with 48KHz)

[pid 30040] open("/dev/dsp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
[pid 30040] fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 3), ...}) = 0
[pid 30040] ioctl(4, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff49c) = -1 EINVAL (Invalid argument)
[pid 30040] mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7caa000
[pid 30040] fstat64(4, {st_mode=S_IFCHR|0660, st_rdev=makedev(14, 3), ...}) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_RESET, 0) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffff5e4) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xbffff5e4) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_STEREO, 0xbffff5e4) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0xbffff5e4) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a17d4) = 0
[pid 30040] ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
[pid 30040] munmap(0xb7caa000, 4096)    = 0


aplay on the other hand is fine with 48KHz wav files, but 44KHz mono
files click badly (and lock up aplay at the end, requiring a kill -9),
44KHz STEREO on the other hand works fine.  Strange..

I sent ASUS a technical documentation query, maybe I'll get a response.

> 
> Takashi
> 

Cheers.
	Josh Green




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
