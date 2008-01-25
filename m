From: "Jerone Young" <jerone@gmail.com>
Subject: Re: [PATCH] Remove psuedo master from
	pci/hda/analog_patch.c . It does not function well!
Date: Fri, 25 Jan 2008 08:37:35 -0600
Message-ID: <9f50a7a00801250637v7e6025d7pcdb179bdc323296@mail.gmail.com>
References: <9f50a7a00801242311i3fe64fecw70ee75c4b6070359@mail.gmail.com>
	<s5hejc6cp85.wl%tiwai@suse.de>
	<9f50a7a00801250541h78f55d92v3e17d77c7f4b3c1@mail.gmail.com>
	<s5hk5lyj8vl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id C23F424902
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 15:37:36 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so157750ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 06:37:35 -0800 (PST)
In-Reply-To: <s5hk5lyj8vl.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tested both patches. They work and master volume works for both
Speakers & IEC958. It can controll up and down volume.

 Speakers now mute.

One issue though when you mute the Master it does not mute IEC958.  It
will mute the speakers but not the IEC958 PCM stream. I am not sure if
this desired behavior?

Oh also AC3 passthrough still works fine (you really can't manipulate
this audio). I streamed some Doubly 5.1 streams over and they worked
fine.

Besides that one issue you should put those 2 patches upstream.

On Jan 25, 2008 8:08 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 25 Jan 2008 07:41:48 -0600,
> Jerone Young wrote:
> >
> > Ok less explication this time ;-) .. it was a late night. I have found
> > something interesting though.
>
> Thanks ;)
>
> > I took some time and actually evaluated the behavior of the Windows
> > Vista Driver by Analog Devices was done for the AD1984. They do not
> > have a PCM mixer, instead each indivdual application has there own
> > mixer (this is a windows feature), and when you manipulate the
> > individual mixer it manipulates the audio of that application. But
> > there is not a PCM mixer for all apps. Just a Master. Also they have
> > IEC958 (SDPIF) seen as a second sound device. It appears that they
> > made what we call PCM the Master.
>
> Maybe Windows driver doesn't use the analog loopback feature inside
> the codec, but does everything on software.
>
> > Now looking at our driver, it appears we should be doing the same. I
> > actually have a good example why. If I am running playback through
> > IEC958 (SDPIF) and I do anything to the PCM mixer it has no effect on
> > PCM audio coming from applications that are running through IEC958.
> > Only when I go to the application (assuming the application has it's
> > own mixer code .. we will say VLC is a good example), does the actual
> > PCM for that application get effected. So if I mute the PCM mixer, PCM
> > audio runs over IEC958 without being muted, it only mutes it for
> > speaker and the headphones.
>
> OK now I see the problem.  IEC958 isn't assigned to the master
> volume/switch list indeed.
>
> > What I see here is what we label as PCM is actually just the Master
> > volume for Speaker & Headphones. But does not actually manipulate the
> > PCM audio.
>
> Correct.  It's because the SPDIF has an individual (a sort of) DAC.
> So, we need to adjust this as well.
>
> > So really PCM really should be made Master Playback as it really does
> > not manipulate PCM audio but just the  how it is played back through
> > Speaker & Headphones.
>
> A fix is easy, but this might cause another problem when a non-audio
> signal is sent.
>
> Could you try the patch below with the latest HG tree?  (Or, you can
> apply this after my previous patch to 1.0.16-rc1.)
> If the SPDIF volume/switch are changed together with the master
> successfully, then please test AC3 or DTS output if possible.  I'd
> like to know whether it breaks now.
> If it still works, I'll happily apply the patch to the upstream tree.
>
>
> Thanks,
>
> Takashi
>
> ---
>
> diff -r 19029da61288 pci/hda/patch_analog.c
> --- a/pci/hda/patch_analog.c    Fri Jan 25 11:56:57 2008 +0100
> +++ b/pci/hda/patch_analog.c    Fri Jan 25 15:04:01 2008 +0100
> @@ -139,6 +139,7 @@ static const char *ad_slave_vols[] = {
>         "Headphone Playback Volume",
>         "Mono Playback Volume",
>         "Speaker Playback Volume",
> +       "IEC958 Playback Volume",
>         NULL
>  };
>
> @@ -151,6 +152,7 @@ static const char *ad_slave_sws[] = {
>         "Headphone Playback Switch",
>         "Mono Playback Switch",
>         "Speaker Playback Switch",
> +       "IEC958 Playback Volume",
>         NULL
>  };
>
> @@ -3078,6 +3080,7 @@ static const char *ad1884_slave_vols[] =
>         "Internal Mic Playback Volume",
>         "Docking Mic Playback Volume"
>         "Beep Playback Volume",
> +       "IEC958 Playback Volume",
>         NULL
>  };
>
>
