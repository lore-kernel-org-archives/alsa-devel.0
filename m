From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: ioctl32 on ppc64
Date: Tue, 14 Sep 2004 01:38:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87acvtpwo7.fsf@blackdown.de>
References: <87fz5notfg.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87fz5notfg.fsf@blackdown.de> (Juergen Kreileder's message of
	"Mon, 13 Sep 2004 03:21:07 +0200")
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

Juergen Kreileder <jk@blackdown.de> writes:

> Doing rate conversion with a plugin defined in .asoundrc works for
> the pure 32-bit and 64-bit cases but not for the mixed 32-bit/64-bit
> case, it fails with "ALSA lib pcm_hw.c:549:(snd_pcm_hw_start)
> SNDRV_PCM_IOCTL_START failed: Broken pipe":

This seems to be related to the mmap mode.  "aplay -vDhw:0 48000.wav"
works both with 32-bit and 64-bit versions of aplay but "aplay
-MvDhw:0 48000.wav" only works with the 64-bit version.  The 32-bit
version fails with:

$ aplay -MvDhw:0 48000.wav 
Playing WAVE '48000.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Hardware PCM card 0 'SB Audigy 2 NX' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 85333
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 0
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken pipe
Aborted by signal Interrupt...


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux/java2-status/


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
