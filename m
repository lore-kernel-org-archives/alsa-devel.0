From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Tue, 18 Feb 2014 19:33:29 -0600
Message-ID: <CADLC3L0PEC_sVrw-+PpQkodvFKOFNicvdL3M5LbiO1Ok8yKkbQ@mail.gmail.com>
References: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
 <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
 <CAN8ccia-cja=_Qh1cwtpvwoxB21F1MVAWYD9reefOn5z7Z0szQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 76BB22652C4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 02:33:29 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id t61so12421441wes.28
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 17:33:29 -0800 (PST)
In-Reply-To: <CAN8ccia-cja=_Qh1cwtpvwoxB21F1MVAWYD9reefOn5z7Z0szQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 18, 2014 at 6:52 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
>> >>> I have a HP ProDesk 600 G1 machine which seems to have some strange
>> > behavior with the front headphone jack(s) running under Fedora 20
>> > (running 3.13.2 kernel):
>
>   HP ProDesk 600 G1 SFF
>
> Do SFF mean small form factor model ?
>
>
> HD audio with Realtek ALC221 codec
> DTS Studio Sound audio management technology
> Microphone and headphone front ports (3.5mm)
> Line-out and Line-In rear Ports (3.5mm)
> Multi-streaming capable
> Internal speaker (standard)
>
> Since all-in-one-pc model is usng ALC3228
>
> DTS Sound+(tm); Realtek ALC 3228 Audio - 16 & 24-bit PCM; High performance
> integrated stereo speakers; Volume control and mute buttons; Stereo
> headphone jack; Microphone in; Stereo line out

Yes, this is the small form factor. It is definitely ALC221 (I checked
the codec chip on the system board).

>
>
>> >
>> >>> This machine has two front jacks: a headphone jack and a
>> > microphone/headphone jack. When the headphones are plugged into the
>> > headphone jack, there's usually no change in the sound outputs list in
>> > the Sound control panel. The audio (mostly) works if the audio output
>> > device is set to Analog Output, but sometimes spuriously changes back
>> > to Speakers and the headphone output stops working (I suspect maybe
>> > from a spurious jack-sensing event, though I'm not certain). More
>> > confusingly, a couple of times I have gotten it into the state
>> > (through various fiddling with jacks and playing in the Sound control
>> > panel) where plugging into this jack is detected and causes the
>> > Headphone output to be selected in the control panel. I haven't been
>> > able to figure out consistently what causes this to happen.
>> >
>> >>> If the headphone is plugged into the microphone/headphone jack, then
>> > the control panel consistently switches to the Headphone output and
>> > consistently switches back the way it was when it's unplugged.
>> > However, there's no actual audio output coming out of that jack. (From
>> > some of the HP manuals, it sounds like with the Windows driver, when
>> > you plug into this jack, it's supposed to pop up a prompt asking you
>> > whether you want to use it as a microphone or headphones.)
>> >
>> >>> The other strange thing is that intermittently, on the headphone jack
>> > you'll start getting a bunch of loud static (clicking noises) and any
>> > actual audio playback becomes very faint and distorted.
>> >
>> >>> I'm guessing perhaps something isn't being initialized/setup properly
>> > in the codec, causing this kind of erratic behavior. The alsa-info
>> > output is uploaded at:
>> >
>> >
>> > http://www.alsa-project.org/db/?f=594e837b7af07ffbe3473cf807465bc81a587880
>> >
>
>> >
>> > Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>> >   Control: name="PCM Playback Switch", index=0, device=0
>> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>> >   Control: name="Line Out Jack", index=0, device=0
>> >   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>> >   Amp-Out vals:  [0x00 0x00]
>> >   Pincap 0x00010014: OUT EAPD Detect
>> >   EAPD 0x2: EAPD
>> >   Pin Default 0x01014020: [Jack] Line Out at Ext Rear
>> >     Conn = 1/8, Color = Green
>> >     DefAssociation = 0x2, Sequence = 0x0
>> >
>> > it is a driver bug which assign PCM playback Switch to Line Out Jack
>> >
>> > try the patch  https://bugzilla.kernel.org/attachment.cgi?id=124971
>>
>> With this patch, I get no audio output at all (totally silent on all
>> ports). Even with playing around with alsamixer and muting/unmuting
>> outputs I could not get anything coming out.
>>
>> The alsa-info output from the patched kernel is here:
>>
>> http://www.alsa-project.org/db/?f=df5874b4fdc01fd6d2c9541c9cde380fe844ac6c
>
>
> autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>     speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
>     hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>     mono: mono_out=0x0
>     inputs:
>       Mic=0x1a
>       Line=0x1b
>
> do you mean one of the front panel jacks support TRRS headset ?

I think that is what the labelling is indicating, yes.

>
> use hda-jack-sense-test to find the nodes of front panel jacks and rear
> panel jacks

>From what I can tell:

When the headphone-only jack is plugged into, nothing happens with jack sensing
When the headphone/mic jack is plugged into, both Pin 0x1a (Black Mic)
and Pin 0x21 (Black HP Out) show present
When the rear line out jack is plugged into, Pin 0x14 (Green Line Out)
shows present
When the rear line in jack is plugged into, nothing happens with jack sensing

>
>> >
>> > Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
>> >   Control: name="Speaker Playback Volume", index=0, device=0
>> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>> >   Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
>> >   Amp-Out vals:  [0x00 0x00]
>
>> > Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
>> >   Control: name="PCM Playback Volume", index=0, device=0
>> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>
> if small form factor is multistreaming capable , line out and headphone have
> to use different audio output 0x02 and 0x03 instead of sharing the same
> audio output 0x03
>
> http://www.intel.com/support/motherboards/desktop/sb/CS-034206.htm
>
> you still need to modify patch_realtek.c
>
> spec->gen.indep_hp = 1;

I did try enabling the indep_hp hint in the codec sysfs files as
described in Documentation/sound/alsa/HD-Audio.txt. That did get the
"Independent HP" mixer control to show up and I had the separate PCM
devices (hw:1,0 and hw:1,2). However playing audio into both of those
produced the same output, and it still had the loud clicking/popping
noises and distorted audio (sounds like clipping even though the audio
isn't very loud) on the headphone jack. Let me know if you think your
patch would do anything more, and I can try it.

I did notice some strange things when playing with alsamixer: Playing
with the "Line" mixer control changes the audio quality (higher levels
seem to be less distorted). Changing the Input Source selection under
the capture settings seems to affect the amount of distortion and
clicking noises, too. I'm not sure why these settings should have any
effect on playback. It's also not very repeatable - it seems like on
different boots and/or power cycles, or depending on what I've been
playing with before, the results are different. It's like the codec is
somehow misconfigured and not routing signals the way they should be.

>
>
> @@ -1493,16 +1497,26 @@ static bool indep_hp_possible(struct hda_codec
> *codec)
>      struct hda_gen_spec *spec = codec->spec;
>      struct auto_pin_cfg *cfg = &spec->autocfg;
>      struct nid_path *path;
> +    hda_nid_t nid;
>      int i, idx;
>
> -    if (cfg->line_out_type == AUTO_PIN_HP_OUT)
> -        idx = spec->out_paths[0];
> -    else
> -        idx = spec->hp_paths[0];
> -    path = snd_hda_get_path_from_idx(codec, idx);
> +    if (cfg->line_out_type != AUTO_PIN_LINE_OUT)
> +        return false;
> +
> +    path = snd_hda_get_path_from_idx(codec, spec->out_paths[0]);
>      if (!path)
>          return false;
> +    nid = path->path[0];
>
> +    idx =  spec->hp_paths[0];
> +    path = snd_hda_get_path_from_idx(codec, idx);
> +    if (!path)
> +        return false;
> +
> +    /* Headphone and Line Out must use different Audio Output */
> +    if (path->path[0] == nid)
> +        return false;
> +
>      /* assume no path conflicts unless aamix is involved */
>      if (!spec->mixer_nid || !is_nid_contained(path, spec->mixer_nid))
>          return true;
>
>
