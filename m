From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Sat, 17 Jul 2010 12:30:43 +0800
Message-ID: <AANLkTimYGgtBWODa8RO0LvPdPExbeuS9XuDz_x79wOOS@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 22C9B1037FB
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 06:30:45 +0200 (CEST)
Received: by vws9 with SMTP id 9so3312137vws.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2010 21:30:43 -0700 (PDT)
In-Reply-To: <s5hiq4or5cz.wl%tiwai@suse.de>
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

2010/7/10 Takashi Iwai <tiwai@suse.de>

> At Fri, 9 Jul 2010 21:13:52 +0800,
> Raymond Yau wrote:
>
>
> Other subsystem, other behavior.
> The detection of underrun is even unreliable on ALSA native, so user
> can't expect it'll get underrun.
>

>From my testing , only hda_intel can run the alsa-lib/test/latency with
-m512 -M512 , au8830 always fail because of xrun and pulse cannot start the
test


Did the latency test require the driver to support SNDRV_PCM_INFO_SYNC_START
?

latency.c seem using a very large value for the start_threshold

    err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
0x7fffffff);



 ./latency -r 44100 -Phw:1 -Chw:1 -m 512 -M 512
!!!Scheduler set to Round Robin with priority 99 FAILED!!!
Playback device is hw:1
Capture device is hw:1
Parameters are 44100Hz, S16_LE, 2 channels, non-blocking mode
Poll mode: no
Loop limit is 1323000 frames, minimum latency = 512, maximum latency = 512
buffer_size :0 252
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 512
  period_size  : 256
  period_time  : 5804
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 256
  period_event : 0
  start_threshold  : 2147483647
  stop_threshold   : 512
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
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 512
  period_size  : 256
  period_time  : 5804
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 256
  period_event : 0
  start_threshold  : 2147483647
  stop_threshold   : 512
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
Trying latency 512 frames, 11609.977us, 11.609977ms (86.1328Hz)
Success
Playback:
*** frames = 1323512 ***
  state       : RUNNING
  trigger_time: 18306.838476235
  tstamp      : 18336.838630238
  delay       : 464
  avail       : 48
  avail_max   : 80
Capture:
*** frames = 1323000 ***
  state       : RUNNING
  trigger_time: 18306.838476235
  tstamp      : 18336.838668663
  delay       : 0
  avail       : 0
  avail_max   : 32
Maximum read: 32 frames
Maximum read latency: 725.624us, 0.725624ms (1378.1250Hz)
Hardware sync
Playback time = 18306.838476, Record time = 18306.838476, diff = 0
