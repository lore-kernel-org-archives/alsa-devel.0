From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1 latency / capture period
Date: Wed, 16 Jun 2004 16:14:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087416890.25102.21.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey,

I am having a problem with the emu10k1 driver where I am unable to set
the capture period lower than 512.  The result is that the lowest
achievable input to output latency is in the neighborhood of 40ms.

I have tried with several different ALSA versions, from 0.9 through the 
latest CVS as of yesterday.

Here is the output from running the 'latency' test program from
alsa-lib.

debian:/usr/src/alsa-cvs/alsa-lib/test# ./latency -m 1024 -M 1024  -t 1
-p
Scheduler set to Round Robin with priority 99...
Playback device is hw:0,0
Capture device is hw:0,0
Parameters are 22050Hz, S16_LE, 2 channels, non-blocking mode
Wanted tick time: 1us, poll mode: yes
Loop limit is 661500 frames, minimum latency = 1024, maximum latency =
1024
Hardware PCM card 0 'Sound Blaster Audigy2' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050 (22050/1)
msbits       : 16
buffer_size  : 1024
period_size  : 512
period_time  : 23219
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 1
avail_min    : 16
xfer_align   : 4
start_threshold  : 2147483647
stop_threshold   : 1024
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Sound Blaster Audigy2' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050 (22050/1)
msbits       : 16
buffer_size  : 1024
period_size  : 512
period_time  : 23219
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 1
avail_min    : 16
xfer_align   : 4
start_threshold  : 2147483647
stop_threshold   : 1024
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Trying latency 1024 frames, 46439.909us, 46.439909ms (21.5332Hz)
Using tick time 1000us
Success
Playback:
*** frames = 662528 ***
state       : RUNNING
trigger_time: 1087415794.855524000
tstamp      : 1087415824.860520000
delay       : 1022
avail       : 2
avail_max   : 38
Capture:
*** frames = 661504 ***
state       : RUNNING
trigger_time: 1087415794.855428000
tstamp      : 1087415824.860645000
delay       : 40
avail       : 40
avail_max   : 56
Maximum read: 56 frames
Maximum read latency: 2539.683us, 2.539683ms (393.7500Hz)
Playback time = 1087415794.855524, Record time = 1087415794.855428, diff
= 96

Here is what happens when I try to set the peiod size any lower:

debian:/usr/src/alsa-cvs/alsa-lib/test# ./latency -m 512 -M 512  -t 1 -p
Scheduler set to Round Robin with priority 99...
Playback device is hw:0,0
Capture device is hw:0,0
Parameters are 22050Hz, S16_LE, 2 channels, non-blocking mode
Wanted tick time: 1us, poll mode: yes
Loop limit is 661500 frames, minimum latency = 512, maximum latency =
512

It just exits.

I have the same problem with JACK, attempting to set the period size
lower than 512 results in an error.

I know that the hardware is capable of much lower latencies than this,
as there are two different ASIO drivers available on Windows for this
card that provide latencies in the 2-5ms range.

I have posted this to linux-audio-dev and elsewhere, so far I am not
getting much of a response other than 'yes, I have that problem too'. 
It seems to be universally acknowledged but there is not a lot being
done about it.  I have seen a lot of claims to the effect that the
design of ALSA is superior to ASIO, that it allows more than two
interrupts per buffer, etc. - so why are the ALSA drivers for this very
common device an order of magnitude worse in latency than the ASIO
drivers?

Are there any plans to address this?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
