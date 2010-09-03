From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Fri, 3 Sep 2010 15:23:54 +0800
Message-ID: <AANLkTikKj7khi=sZNXbcW7m3-oWx0fXshY9Vn18NH+B8@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<s5hmxs0h437.wl%tiwai@suse.de> <4C809DB3.9090201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B23652450F
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 09:23:54 +0200 (CEST)
Received: by ewy21 with SMTP id 21so825615ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 00:23:54 -0700 (PDT)
In-Reply-To: <4C809DB3.9090201@canonical.com>
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

2010/9/3 David Henningsson <david.henningsson@canonical.com>

> 2010-09-02 11:44, Takashi Iwai skrev:
> > At Thu, 02 Sep 2010 11:24:45 +0200,
> > David Henningsson wrote:
> >>
> >> 2010-09-02 10:06, Takashi Iwai skrev:
> >>> At Wed, 01 Sep 2010 15:26:54 +0200,
> >>> David Henningsson wrote:
> >>>>
> >>>> 2010-08-30 15:08, Takashi Iwai skrev:
> >>>>> At Mon, 30 Aug 2010 15:01:29 +0200,
> >>>>> David Henningsson wrote:
> >>>>>>
> >>>>>> 2010-08-30 10:01, Takashi Iwai skrev:
> >>>>>>> At Sat, 28 Aug 2010 06:58:20 +0800,
> >>>>>>> Raymond Yau wrote:
> >>>>>>>>
> >>>>>>>> 2010/8/28 David Henningsson <david.henningsson@canonical.com>
> >>>>>>>>
> >>>>>>>>> 2010-08-27 17:43, Clemens Ladisch skrev:
> >>>>>>>>>> David Henningsson wrote:
> >>>>>>>>>>> So I've discovered that my sound card has a "PCM Playback
> Volume"
> >>>>>>>>>>> control, but changing that control does not alter the volume.
> >>>>>>>>>>>
> >>>>>>>>>>> Interestingly enough, this control does not come from the HDA
> parser, it
> >>>>>>>>>>> is added by alsactl at boot time...!
> >>>>>>>>>>
> >>>>>>>>>> This control was created by the software volume plugin.  When
> not using
> >>>>>>>>>> this plugin, the control does not have any effect.
> >>>>>>>>>>
> >>>>>>>>>> To get rid of it, delete its entry from /etc/asound.state.
> >>>>>>>>>
> >>>>>>>>> Hmm, I wonder if this is an Ubuntu-specific bug then? Because
> when I run
> >>>>>>>>> Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM
> Playback
> >>>>>>>>> Volume" control is still there (and there is no asound.state,
> neither in
> >>>>>>>>> /etc or in /var/lib/alsa).
> >>>>>>>>> When I use the plughw interface, the "PCM Playback Volume" does
> not
> >>>>>>>>> affect volume output. Should I use another device string to test
> the
> >>>>>>>>> softvol plugin, to see if it's there or not?
> >>>>>>>>
> >>>>>>>> The softvol plugin it is defined in "front" device in
> >>>>>>>> /usr/share/alsa/cards/HDA-Intel.conf
> >>>>>>>>
> >>>>>>>> reason is some HDA codec does not has any hardware volume control
> (analog)
> >>>>>>>>
> >>>>>>>> this user-defined control only effective when the application use
> "front"
> >>>>>>>> device
> >>>>>>>
> >>>>>>> Hm, but if PA opens the device with SND_PCM_NO_SOFTVOL flag, the
> >>>>>>> softvol should be skipped.
> >>>>>>
> >>>>>> But that does not apply to the mixer controls as well, does it?
> >>>>>
> >>>>> It does.  The mixer element is created when this kind of PCM stream
> is
> >>>>> opened without SND_PCM_NO_SOFTVOL flag.  Then it leaves the control
> >>>>> for the later use, and alsactl saves/restores it.  So, it's a
> chicken-
> >>>>> and-egg problem.
> >>>>
> >>>> Sounds a little strange to me. Thinking in general, if something is
> >>>> created when a stream is opened, that something should be destroyed
> when
> >>>> the stream is closed.
> >>>
> >>> It's not about the stream-level volume.  It's about the global volume.
> >>> There have been bunch of machines that have no h/w volume control.
> >>> This is the mechanism for such environment.  You certainly don't want
> >>> to reset the system-level volume at each time you close the stream.
> >>
> >> So if it's about the global volume it should be created on startup
> >> rather than when the stream is opened for the first time.
> >
> > Ideally yes.  But pragmatically, no, it didn't work like that at that
> > time.  The change had to be seamless.
> >
> >>>>> Of course, it's possible that it wasn't PA who opened the PCM stream.
> >>>>> But, something opened the stream and it created the mixer element.
> >>>>> This is the correct behavior.
> >>>>
> >>>> And once created, it stays there forever...
> >>>
> >>> Not necessarily forever.  It's alsactl who saves/restores the element
> >>>
> >>>> So even if PA does not
> >>>> create it, we'll just transform a persistent problem to an suddenly
> >>>> appearing problem?
> >>>
> >>> Yes, it's just because you started an app that doesn't cope with PA.
> >>> And, it's PA who doesn't cope with softvol setup.  This is the
> >>> conflicting situation.
> >>
> >> So as I understand it PA should call snd_pcm_open with the
> >> SND_PCM_NO_SOFTVOL, which it currently does not. It still puzzles me
> >> however how PA manages to open without that flag, which creates a mixer
> >> control, and later on that softvol control has no effect.
> >
> > PA opens the "hw" device in general.  This skips the whole things.
>
> Right, so it tries both, which has the side effect of creating a volume
> control, and then prefers hw.
>
> >>> Now the system doesn't know whether you'll start the non-PA app
> >>> again.  So, the volume has to be retained.
> >>>
> >>>> Anyway, do we want softvol at all for HDA? Wouldn't that be such an
> >>>> unusual use case, that those people that can't adjust volume any other
> >>>> way, can add that softvol themselves in .asoundrc?
> >>>
> >>> The softvol itself does nothing if the corresponding h/w volume
> >>> control exists.  It's activated only when the corresponding volume
> >>> element is unavailable.
> >>
> >> Right, but I have a "Master" volume, a "Front" volume, "Headphone"
> >> volume and so on, so I have all the HW volumes I need, it's just that
> >> none of them happen to be labeled "PCM".
> >
> > That's the problem.  The front playback stream is supposed to have
> > a PCM volume control.
>
> May I kindly ask you to reconsider that statement? AFAIK, for Realtek
> chips it is more common not to have a PCM volume control (and I haven't
> checked the rest). So that would mean we have tons of bugs in the HDA
> driver(s).
>
> So, this softvol is only useful if all these three conditions are met:
>
> 1) you're opening "front:x" (or the "surround:x" variants), not
> "plughw:x", "hw:x", "default:x", "dmix:x" or anything else.
>
> 2) you have no playback volume what so ever
>
> 3) you're not using PA or another sound server with its own software
> volume mechanism
>
> And so far I haven't came across a single HDA that fulfills condition
> 2), and I find the combination even more unlikely, but YMMV.
>
> >>>>>> I think
> >>>>>> we still have a problem with PA assuming that it can change the PCM
> >>>>>> volume control to change the output volume.
> >>>>>
> >>>>> PA can check whether it's a user-defined control or not.
> >>>>
> >>>> Would that be safe - I mean, can't there be user-defined controls PA
> >>>> *should* care about?
> >>>
> >>> It depends on the driver implementation, but as long as PA does
> >>> software volume control by itself, and as long as the control elements
> >>> are mixer elements, they can be ignored.
> >>
> >> Interesting. I went looking into the snd_mixer_selem_* documentation (PA
> >> uses the simple mixer interface), but I couldn't find a function for
> >> determining whether a control is user-defined or not, would you mind
> >> pointing me to it? Thanks!
> >
> > There seems no direct access from the mixer API.
> > But you can parse the mixer element to get hcontrol, then snd_ctl_elem
> > can be checked for its attribute.
> >
> > Yeah, a new function could be added for controlling it.
> > Or, as an easier option, we can make snd_mixer_open() or
> > snd_ctl_open() for skipping the user-defined controls with some flag
> > like snd_pcm_open().
>
> What would be really helpful would be if snd_mixer_open() took an
> optional pcm handle, and then only returned the mixer controls that
> affects the signal path of that pcm.
>

The major problem is PA open "front" by both playback and capture

PA should not open "front" for capture

The softvol plugin should check the slave pcm (playback/capture) match with
the name of the control (Playback Volume/ Capture Volume)

There is one control in the alsamixer , but it is unclear that it control
both streams or only the recent stream


I: module-alsa-sink.c: Using 2 fragments of size 32768 bytes, buffer time is
371.52ms
I: module-alsa-sink.c: Time scheduling watermark is 20.00ms
D: module-alsa-sink.c: hwbuf_unused_frames=0
D: module-alsa-sink.c: setting avail_min=62005
I: module-alsa-sink.c: Volume ranges from 0 to 39.
I: module-alsa-sink.c: Volume ranges from -58.50 dB to 0.00 dB.
I: alsa-util.c: ALSA device lacks independant volume controls for each
channel.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Soft volume PCM
D: alsa-util.c: Control: PCM Playback Volume
D: alsa-util.c: min_dB: -51
D: alsa-util.c: max_dB: 0
D: alsa-util.c: resolution: 256
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 62005
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c: Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 62005
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_thresh
D: module-alsa-sink.c: Read hardware volume: 0: 100% 1: 100%
D: module-alsa-sink.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+27
I: module-alsa-sink.c: Starting playback.
I: module.c: Loaded "module-alsa-sink" (index: #2; argument: "device_id=1
sink_name=alsa_output.pci_8086_284b_sound_card_0_alsa_playback_0 tsched=1").
D: module-hal-detect.c: Loading module-alsa-source with arguments
'device_id=1
source_name=alsa_input.pci_8086_284b_sound_card_0_alsa_capture_0 tsched=1'
D: alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: module-alsa-source.c: Successfully opened device front:1.
I: module-alsa-source.c: Successfully enabled mmap() mode.
I: module-alsa-source.c: Successfully enabled timer-based scheduling mode.
I: (alsa-lib)control.c: Invalid CTL front:1
I: alsa-util.c: Unable to attach to mixer front:1: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:1'
I: alsa-util.c: Using mixer control "Capture".
I: source.c: Created source 3
"alsa_input.pci_8086_284b_sound_card_0_alsa_capture_0" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-source.c: Using 2 fragments of size 32768 bytes, buffer time
is 371.52ms
I: module-alsa-source.c: Time scheduling watermark is 20.00ms
D: module-alsa-source.c: hwbuf_unused_frames=0
D: module-alsa-source.c: setting avail_min=62005
I: module-alsa-source.c: Volume ranges from 0 to 54.
I: module-alsa-source.c: Volume ranges from -58.50 dB to 22.50 dB.
I: alsa-util.c: All 2 channels can be mapped to mixer channels.
I: module-alsa-source.c: Using hardware volume control. Hardware dB scale
supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Soft volume PCM
D: alsa-util.c: Control: PCM Playback Volume
D: alsa-util.c: min_dB: -51
D: alsa-util.c: max_dB: 0
D: alsa-util.c: resolution: 256
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 62005
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c: Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : CAPTURE
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 62005
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshol
D: module-alsa-source.c: Read hardware volume: 0:  62% 1:  62%
