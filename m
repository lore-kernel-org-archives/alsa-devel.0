From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: trident driver bug
Date: Wed, 19 Mar 2003 20:29:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303192029030.1351-100000@pnote.perex-int.cz>
References: <200303191810.h2JIA2o01270@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303191810.h2JIA2o01270@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Mar 2003, Paul Davis wrote:

> there still appears to be a bug in the trident driver. i have been
> running jack with a period size of 1024, and it works fine. when i
> change that to 4096 frames, the kernel does a hard oops, with the oops
> occuring in enable_hlt(). the rest of the trace doesn't make much
> sense, and i cannot feed it to ksymoops because the machine locks
> hard.  what can i do to make it eas(y|ier) to debug?

I cannot reproduce it here. Could you try the same command?

test:/home/perex # aplay -v -F 92870 -B 185750 audio/audio_10.wav
Playing WAVE 'audio/audio_10.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Trident TRID4DWAVENX' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8192
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Aborted by signal Interrupt...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
