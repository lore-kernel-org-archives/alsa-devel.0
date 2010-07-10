From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Sat, 10 Jul 2010 10:07:18 +0800
Message-ID: <AANLkTiljxIAEnWRXaloxtftNNOs2-i4lT1x7fOtBmURb@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de> <4C376182.5050807@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CFD0244B2
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 04:07:19 +0200 (CEST)
Received: by gxk26 with SMTP id 26so1784868gxk.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 19:07:18 -0700 (PDT)
In-Reply-To: <4C376182.5050807@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>

>
>
> The question is - is there an application that detects the underrun
> condition and actually acts on that condition? If so, this could be a
> regression for that app. For other apps it's an improvement, for the
> reasons originally stated.
>
> // David
>

Some application (e.g. xmms and audacious) allow user to configure the
period/buffer time

I don't know why the alsa-lib/test/latency did not run when using pulse
device


./latency -P pulse -C pulse -m 8192 -M 8192 -t 1 -p
/home/raymond/alsa-lib/test/.libs/lt-latency: invalid option -- 't'
!!!Scheduler set to Round Robin with priority 99 FAILED!!!
Playback device is pulse
Capture device is pulse
Parameters are 22050Hz, S16_LE, 2 channels, non-blocking mode
Poll mode: yes
Loop limit is 661500 frames, minimum latency = 8192, maximum latency = 8192



alsa-lib/test/latency -P hw:1,0 -C hw:1,0 -m 8192 -M 8192 -t 1 -p
/home/raymond/alsa-lib/test/.libs/lt-latency: invalid option -- 't'
!!!Scheduler set to Round Robin with priority 99 FAILED!!!
Playback device is hw:1,0
Capture device is hw:1,0
Parameters are 22050Hz, S16_LE, 2 channels, non-blocking mode
Poll mode: yes
Loop limit is 661500 frames, minimum latency = 8192, maximum latency = 8192
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 22050
  exact rate   : 22050 (22050/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 4096
  period_time  : 185759
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 2147483647
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 22050
  exact rate   : 22050 (22050/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 4096
  period_time  : 185759
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 2147483647
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
Trying latency 8192 frames, 371519.274us, 371.519274ms (2.6917Hz)
Success
Playback:
*** frames = 671744 ***
  state       : RUNNING
  trigger_time: 14895.45132386
  tstamp      : 14925.138525741
  delay       : 8144
  avail       : 48
  avail_max   : 4152
Capture:
*** frames = 663552 ***
  state       : RUNNING
  trigger_time: 14895.45132386
  tstamp      : 14925.138585923
  delay       : 1
  avail       : 1
  avail_max   : 4097
Maximum read: 4096 frames
Maximum read latency: 185759.637us, 185.759637ms (5.3833Hz)
Hardware sync
Playback time = 14895.45132, Record time = 14895.45132, diff = 0
