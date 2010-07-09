From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Sat, 10 Jul 2010 06:58:25 +0800
Message-ID: <AANLkTinIl5AyMZyJNabLzdfvGRjU8A6wikmoO4edGt9v@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de> <4C376182.5050807@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 89ABA10380E
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Jul 2010 00:58:26 +0200 (CEST)
Received: by vws9 with SMTP id 9so3100189vws.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 15:58:25 -0700 (PDT)
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

> 2010-07-09 18:23, Takashi Iwai skrev:
> > At Fri, 9 Jul 2010 21:13:52 +0800,
> > Raymond Yau wrote:
> >>>>>>> The second one (Do not report underruns to the ALSA layer) is more
> a
> >>>>>>> change of behavior, which could be questioned. The arguments for
> >>>>>>> removing that code are these:
> >>>>>>>
> >>>>>>>  * If pulseaudio gets an underrun, the normal way to end that
> >>> underrun
> >>>>>>> is to feed it with more buffers. This is different from the ALSA
> way
> >>> of
> >>>>>>> dealing with underruns, which requires hardware buffer pointers to
> >>> be reset.
> >>>>>>>  * In addition, underrun signals are delivered asynchronously from
> >>>>>>> pulseaudio. This means that there might be more buffers on the way
> >>> to
> >>>>>>> pulseaudio when the underrun is reported, making the underrun
> >>> obsolete.
> >>>>>>> Unfortunately, there is currently no known way to determine whether
> >>> this
> >>>>>>> is the case or not.
> >>>>>>
> >>>>>> I think this helps for normal use-cases, so it'd be good to apply.
> >>>>>> But, I prefer having a runtime option for such a behavior change
> >>>>>> (although the default value can be the new behavior).
> >>>>>>
> >>>>>> Care to add it?
> >>>>>
> >>>>> Sure, I can do that - it sounds like a good idea to have it
> >>> configurable.
> >>>>> Just so I understand you right, exactly how do you expect the user /
> >>>>> application to configure it?
> >>>>
> >>>> I suppose it can be simply added as an alsa-lib plugin config, i.e.
> >>>> in SND_PCM_PLUGIN_DEFINE_FUNC(pulse) of
> alsa-plugins/pulse/pcm_pulse.c,
> >>>> add the code like below:
> >>>>
> >>>>       int handle_underrun = 0;
> >>>>       ...
> >>>>
> >>>>       snd_config_for_each(i, next, conf) {
> >>>>               ...
> >>>>               if (strcmp(id, "handle_underrun") == 0) {
> >>>>                       handle_underrun = snd_config_get_bool(n);
> >>>>                       if (handle_underrun < 0) {
> >>>>                               SNDERR("Invalid value for %s", id);
> >>>>                               return handle_underrun;
> >>>>                       }
> >>>>                       continue;
> >>>>               }
> >>>>       }
> >>>
> >>> FYI, I modified the patch and applied to git tree right now.
>
> Thanks! I've been on holiday this week but thought I would do it in the
> following week. Only nice to see it being done :-)
>
> >> This behaviour is a little bit strange , using the same buffer size 128
> >>
> >> aplay -Dhw:0,0 --buffer-size=128 test.wav
> >>
> >> report underrun
> >>
> >>
> >> aplay -D pulse --buffer-size=128 test.wav
> >>
> >> did not report underrun but the sound is distorted
> >
> > Other subsystem, other behavior.
> > The detection of underrun is even unreliable on ALSA native, so user
> > can't expect it'll get underrun.
>


Before this patch , using pulse device also report underrun


When using hw device ,the sound is quite good , at least I cannot hear any
distortion and the reported underrun  only appear a few times on the
terminal


underrun!!! (at least 0.210 ms long)

Did alsa-lib calculate 0.210 ms from hw_ptr , app_ptr and sample rate ?

aplay -v -Dhw:0,0 --buffer-size=128 t3.wav
Playing WAVE 't3.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Hardware PCM card 0 'Aureal Vortex au8830' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 128
  period_size  : 32
  period_time  : 725
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 32
  period_event : 0
  start_threshold  : 128
  stop_threshold   : 128
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
underrun!!! (at least 0.210 ms long)
Status:
  state       : XRUN
  trigger_time: 2794.391051578
  tstamp      : 2794.393149452
  delay       : 0
  avail       : 153
  avail_max   : 153
underrun!!! (at least 0.001 ms long)
Status:
  state       : XRUN
  trigger_time: 2801.590388423
  tstamp      : 2801.590394868
  delay       : 0
  avail       : 135
  avail_max   : 135
underrun!!! (at least 0.032 ms long)
Status:
  state       : XRUN
  trigger_time: 2801.718347873
  tstamp      : 2801.718661699
  delay       : 0
  avail       : 153
  avail_max   : 153
underrun!!! (at least 0.067 ms long)
Status:
  state       : XRUN
  trigger_time: 2805.978507564
  tstamp      : 2805.979173807
  delay       : 0
  avail       : 162
  avail_max   : 162
underrun!!! (at least 0.065 ms long)
Status:
  state       : XRUN
  trigger_time: 2807.118761300
  tstamp      : 2807.119411502
  delay       : 0
  avail       : 162
  avail_max   : 162
underrun!!! (at least 0.058 ms long)
Status:
  state       : XRUN
  trigger_time: 2808.685565670
  tstamp      : 2808.686139666
  delay       : 0
  avail       : 153
  avail_max   : 153
underrun!!! (at least 0.001 ms long)
Status:
  state       : XRUN
  trigger_time: 2808.699838404
  tstamp      : 2808.699844705
  delay       : 0
  avail       : 133
  avail_max   : 133



>
> > The biggest drawback by this change is that whether the sound goes
> > well or not isn't reported any more to the application layer.
> > It's an unfortunate design, but it's life with PA.
>
> The question is - is there an application that detects the underrun
> condition and actually acts on that condition? If so, this could be a
> regression for that app. For other apps it's an improvement, for the
> reasons originally stated.
>
> // David
>

You have to ask jackd user , they usually fine-tune(increase/decrease) the
period-size of jackd manually based on the occurrence of underrun in order
to achieve the lowest latency


This give a false impression to the user that PA can provide low latency
without under-run and pulse device is even perform better than hw device.


>>  Reporting underruns to ALSA seems to do more bad than good, for these
reasons:

 * If pulseaudio gets an underrun, the normal way to end that underrun is to

   feed it with more buffers. This is different from the ALSA way of dealing

   with underruns, which requires hardware buffer pointers to be reset.

 * In addition, underrun signals are delivered asynchronously from
pulseaudio.

   This means that there might be more buffers on the way to pulseaudio when

   the underrun is reported, making the underrun obsolete. Unfortunately,

   there is currently no known way to determine whether this is the case or

   not.

Do you mean PA server get underrun from the sound driver when you mention
that
if pulseaudio get underrun, the normal way to end that underrun is to feed
it with more buffers." ?

The normal way for ALSA application is to prevent underrun occur rather to
let underrun occur be selecting a larger period size or wake up more
frequently to feed data to the sound card



PA developer often complain the driver did not provide accurate playback
position by the pcm_pointer callback

Did the pulse_pointer callback also provide accurate position of the pulse
device ?
