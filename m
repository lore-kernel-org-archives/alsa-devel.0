From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: latency.c: some feature requests
Date: Sun, 28 Nov 2004 16:32:13 -0500
Message-ID: <1101677534.18348.84.camel@krustophenia.net>
References: <1101617894.21427.9.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
	 <1101667038.18348.4.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411281942520.6878@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411281942520.6878@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-11-28 at 19:44 +0100, Jaroslav Kysela wrote:
> -P plughw:0,3 -C plughw:0,2

Thanks.  Here are the results.  Does this look OK to you?

It looks like the playback runs 64 frames ahead of the capture.  Do you
think this would be a problem from the application's perspective?

rlrevell@mindpipe:~/cvs/alsa-cvs-T3/alsa-lib/test$ ./latency -P plughw:0,3 -C plughw:0,2 -c 16 -r 48000
Scheduler set to Round Robin with priority 99...
Playback device is plughw:0,3
Capture device is plughw:0,2
Parameters are 48000Hz, S16_LE, 16 channels, non-blocking mode
Wanted tick time: 0us, poll mode: no
Loop limit is 1440000 frames, minimum latency = 64, maximum latency = 4096
Plug PCM: Copy conversion PCM
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STDI still have not implemented synced start so it looks like the capture and playback are a little out of sync.  
channels     : 16
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 64
period_size  : 32
period_time  : 666
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4
xfer_align   : 4
start_threshold  : 2147483647
stop_threshold   : 64
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'Sound Blaster Audigy2' device 3 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 16
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 64
period_size  : 32
period_time  : 666
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4
xfer_align   : 4
start_threshold  : 2147483647
stop_threshold   : 64
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Plug PCM: Hardware PCM card 0 'Sound Blaster Audigy2' device 2 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 16
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 64
period_size  : 32
period_time  : 666
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4
xfer_align   : 4
start_threshold  : 2147483647
stop_threshold   : 64
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Trying latency 64 frames, 1333.333us, 1.333333ms (750.0000Hz)
Success
Playback:
*** frames = 1440080 ***
state       : RUNNING
trigger_time: 1101676443.293035000
tstamp      : 1101676473.295128000
delay       : 59
avail       : 5
avail_max   : 15
Capture:
*** frames = 1440016 ***
state       : RUNNING
trigger_time: 1101676443.293030000
tstamp      : 1101676473.295506000
delay       : 52
avail       : 52
avail_max   : 52
Maximum read: 32 frames
Maximum read latency: 666.667us, 0.666667ms (1500.0000Hz)
Playback time = 1101676443.293035, Record time = 1101676443.293030, diff = 5

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
