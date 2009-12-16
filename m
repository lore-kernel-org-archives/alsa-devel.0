From: pl bossart <bossart.nospam@gmail.com>
Subject: poll events?
Date: Tue, 15 Dec 2009 19:15:05 -0600
Message-ID: <6160a5130912151715m2e5789d8jfbbe5cc0e5a501b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE332443A
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 02:15:07 +0100 (CET)
Received: by pxi3 with SMTP id 3so315901pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 17:15:06 -0800 (PST)
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

I am trying to understand what the expected behavior of poll() is in
audio applications. I am using the pcm.c test app from alsa-lib with
the following parameters.
./pcm -Dhw -c2 -r48000 -f440  --method write_and_poll
The output looks like this:
snd_pcm_dump():
Hardware PCM card 0 'Intel ICH6' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 8192
  period_time  : 170666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 8192
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0

Now I instrumented the code in sound/core/pcm_native.c to show what
events are returned by snd_pcm_playback_poll(), and I get the
following pattern:

[  176.062986] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.066630] ALSA: null poll event, avail 175 avail_min 8192
[  176.233739] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.237399] ALSA: null poll event, avail 176 avail_min 8192
[  176.404503] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.407652] ALSA: null poll event, avail 152 avail_min 8192
[  176.575257] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.578995] ALSA: null poll event, avail 180 avail_min 8192
[  176.745999] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.749663] ALSA: null poll event, avail 176 avail_min 8192
[  176.916750] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8193 avail_min 8192
[  176.919893] ALSA: null poll event, avail 151 avail_min 8192

It looks like I am getting additional wakeups from poll instead of
waiting for a complete period. Is this supposed to be ok or is there
something broken here? My expectation is that the hardware would only
generate interrupts when a period has elapsed, i.e avail>=avail_min.
The delta shown in dmesg between two POLLOUT events matches the period
duration of 171 ms, I don't understand what generates these additional
null events. Am I missing something?
Thanks for your help.
- Pierre
