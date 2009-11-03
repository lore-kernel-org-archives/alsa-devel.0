From: GNUtoo <GNUtoo@no-log.org>
Subject: MSM DSP
Date: Tue, 03 Nov 2009 17:02:22 +0100
Message-ID: <1257264142.19223.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id A418E244BA
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:02:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,
I've bought an HTC dream,before buying I looked at the feasibility  of
porting GNU/Linux on it(so not Android).
There is a patch(for maing the driver standard) or a standard(everything
is non-standard in android) driver for most of the components.
The biggest problem seems the sound.
So knowing that
codeaurora( https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git ) had alsa in its kenrel I first tried to compile that kernel...but due to numerous bugs(It didn't compile and needed too much fixing) in it android-msm-2.6.29 branch I decided to import alsa in the linuxtogo kernel,and I pushed the sources at a temporary htc-alsa branch at git://gitorious.org/replicant/gnulinuxkernel.git (it's called gnulinux in order to differentiate from an android kernel,I didn't find a good name for it)

from the commit message available here :
http://gitorious.org/replicant/gnulinuxkernel/commit/92945ccd0921e940fc2675dc394141db0f7c1386 

I had to change snd_rpc_ids.vers = 0x00020001 into 
snd_rpc_ids.vers = 0xaa2b1a44 ,and to make minor build system changes
and I had aplay working rapidely...
but only aplay...
mplayer was waiting indefinitely for the following system call:
ioctl(6, 0x400c4150
ls -l /proc/$(pido mplayer)/fd/6 gave /dev/snd/pcmC0D0p
and 0x400c4150 gave that:
SNDRV_PCM_IOCTL_WRITEI_FRAMES = _IOW('A', 0x50, struct snd_xferi)

Then with printks(I had no serial cable(I've looked for a
craddle/docking station with the special HTC connector for easy
soldering...but I didn't found one) so I couldn't use kgdb) I went until
that point:
rc = wait_event_interruptible(the_locks.write_wait, (frame->used == 0)||
(prtd->stopped));
That's in the alsa_send_buffer function in /sound/soc/msm/msm-pcm.c
Then I continued the tracing puting printks everywhere...and I found
that:
with aplay:
msm_pcm_playback_copy in the /sound/soc/msm/msm7k-pcm.c was called
rc = alsa_send_buffer(prtd, buf, fbytes, NULL); was called once
inside alsa_send_buffer (in /sound/soc/msm/msm-pcm.c) the count loop was
only executed once because count was exhausted on the first run
then copy_count is incremented and the audio is configured
then at second call of the alsa_send_buffer the audio is configured and
works.
here's an output of the aplay parameters:

$ aplay -v 05\ -\ Jet\ Set.wav 
Playing WAVE '05 - Jet Set.wav' : Signed 16 bit Little Endian, Rate
44100 Hz, Stereo
Plug PCM: Hardware PCM card 0 'msm-audio' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 4800
  period_size  : 1200
  period_time  : 27210
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1200
  xfer_align   : 1200
  start_threshold  : 4800
  stop_threshold   : 4800
  silence_threshold: 0
  silence_size : 0
  boundary     : 1258291200

note that frame = prtd->out + prtd->out_tail; makes frame->used have a
bad value the first time it is run but as the count is only run once it
doesn't import.

the next runs prtd->out + prtd->out_tail have a good value

with mplayer the story was quite different,even if the beginning was the
same : 
msm_pcm_playback_copy in the /sound/soc/msm/msm7k-pcm.c was also
called,rc = alsa_send_buffer(prtd, buf, fbytes, NULL); was also called 
inside alsa_send_buffer (in /sound/soc/msm/msm-pcm.c)  but once in
alsa_send_buffer,more precisely under the count loop the story changes:
count is not exhausted the first time,because in "xfer = count >
frame->size ? frame->size : count;" the smallest between count and
frame->size is assigned,and so after it does "count -= xfer" and so
count is not 0,because the buffer size detected by mplayer is 19200
insterad of 4800 so here what it does in detail:
it passes 19200 as count here:
fbytes = frames_to_bytes(runtime, frames);
rc = alsa_send_buffer(prtd, buf, fbytes, NULL);
that goes into that:
ssize_t alsa_send_buffer(struct msm_audio *prtd, const char __user *buf,
size_t count, loff_t *pos)
and then the count variable is 19200 in alsa_send_buffer
then there is xfer = count > frame->size ? frame->size : count;
so it assigns the minimum between count and frame->size to xfer
count is still 19200
frame->size is 4800
so xfer becomes 4800
then count -= xfer decrement count but only of 4800
so count is not exhausted and runs another time then :
frame = prtd->out + prtd->out_tail; makes frame->used have a bad
value,and then it blocks here:
rc = wait_event_interruptible(the_locks.write_wait,(frame->used == 0) ||
(prtd->stopped));
because frame->used is not 0.

here an mplayer output:
Forced audio codec: mad
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
dec_audio: Allocating 2048 + 65536 = 67584 bytes for output buffer.
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio:
176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
[libaf] Adding filter dummy 
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Trying preferred audio driver 'alsa', options '[none]'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.15
alsa-init: setup for 1/2 channel(s)
alsa-init: using device default
alsa-init: pcm opened in blocking mode
alsa-init: got buffersize=19200
alsa-init: got period size 300
alsa: 44100 Hz/2 channels/4 bpf/19200 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: ALSA-0.9.x-1.x audio output
AO: Author: Alex Beregszaszi, Zsolt Barat <joy@streamminister.de>
AO: Comment: under developement
Building audio filter chain for 44100Hz/2ch/s16le ->
44100Hz/2ch/s16le...
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Video: no video
Freeing 0 unused video chunks.
Starting playback...
Increasing filtered audio buffer size from 0 to 21248

so the quick solution was to force mplayer to use 4800 as buffer size
with something like that:

diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
index 38e8283..bfbc66d 100644
--- a/sound/soc/msm/msm7k-pcm.c
+++ b/sound/soc/msm/msm7k-pcm.c
@@ -115,7 +115,7 @@ static struct snd_pcm_hardware
msm_pcm_playback_hardware = {
        .rate_max =             USE_RATE_MAX,
        .channels_min =         USE_CHANNELS_MIN,
        .channels_max =         USE_CHANNELS_MAX,
-       .buffer_bytes_max =     MAX_BUFFER_PLAYBACK_SIZE,
+       .buffer_bytes_max =     4800,
        .period_bytes_min =     64,
        .period_bytes_max =     MAX_PERIOD_SIZE,
        .periods_min =          USE_PERIODS_MIN,



but then mplayer seem to loop on an ioctl:
mplayer is frozen here and doesn't respond to other input than ctrl+c:
0.0 (00.0) of 206.0 (03:26.0) ??,?% 
strace shows a lot of :
nanosleep followed by
SNDRV_PCM_IOCTL_STATUS (ioctl(6, 0x806c4120, 0xbe8bc9c8)  = 0)
an analyse of the status shows a constant :
status->delay is 1200,and status->avail is 0,they don't vary over time
and are printed just after that code in snd_pcm_status in
sound/core/pcm_native.c
if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
    runtime->status->state == SNDRV_PCM_STATE_DRAINING)
status->delay = runtime->buffer_size - status->avail;
else
status->delay = 0;

I was told in #mplayerdev that it was because the DSP didn't play the
frames...indeed I hear no sound....

So how should I fix that mess?
*did the quick and dirty fix cause the second problem?
*should I use the DSP directly and make a pulseaudio plugin that talks
to the android driver, instead(the driver seems very buggy)
The good would be support for mp3 and similar things within the DSP,and
that it should be more stable.
The bad is that I already spent *a lot* of time with the alsa kernel
driver...and that writing that will also require some userspaces changes
such as:
*modification of the phone routing in the
"FSO" ( http://www.freesmartphone.org/index.php/Main_Page ) dbus
framework to use pulseaudio
*would require changes in the build system for using
pulseaudio(openembedded(http://wiki.openembedded.net/index.php/Main_Page ))
*may be slow...openmoko stopped to use pulseaudio because of speed
issues.

Denis
