From: "Jerone Young" <jerone@gmail.com>
Subject: Re: [PATCH] Remove psuedo master from
	pci/hda/analog_patch.c . It does not function well!
Date: Fri, 25 Jan 2008 07:41:48 -0600
Message-ID: <9f50a7a00801250541h78f55d92v3e17d77c7f4b3c1@mail.gmail.com>
References: <9f50a7a00801242311i3fe64fecw70ee75c4b6070359@mail.gmail.com>
	<s5hejc6cp85.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F0E110389A
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 14:41:49 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so591186fgb.44
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 05:41:48 -0800 (PST)
In-Reply-To: <s5hejc6cp85.wl%tiwai@suse.de>
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

Ok less explication this time ;-) .. it was a late night. I have found
something interesting though.

I took some time and actually evaluated the behavior of the Windows
Vista Driver by Analog Devices was done for the AD1984. They do not
have a PCM mixer, instead each indivdual application has there own
mixer (this is a windows feature), and when you manipulate the
individual mixer it manipulates the audio of that application. But
there is not a PCM mixer for all apps. Just a Master. Also they have
IEC958 (SDPIF) seen as a second sound device. It appears that they
made what we call PCM the Master.

Now looking at our driver, it appears we should be doing the same. I
actually have a good example why. If I am running playback through
IEC958 (SDPIF) and I do anything to the PCM mixer it has no effect on
PCM audio coming from applications that are running through IEC958.
Only when I go to the application (assuming the application has it's
own mixer code .. we will say VLC is a good example), does the actual
PCM for that application get effected. So if I mute the PCM mixer, PCM
audio runs over IEC958 without being muted, it only mutes it for
speaker and the headphones.

What I see here is what we label as PCM is actually just the Master
volume for Speaker & Headphones. But does not actually manipulate the
PCM audio.

So really PCM really should be made Master Playback as it really does
not manipulate PCM audio but just the  how it is played back through
Speaker & Headphones.

On Jan 25, 2008 1:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 25 Jan 2008 01:11:38 -0600,
> Jerone Young wrote:
> >
> > Hi I noticed after installing 1.0.16rc-1 today that my Thinkpad T61
> > with AD1984 had a Master mixer now. Problem is it's not very good in
> > that it
> > 1) does not follow with PCM (the real master) volume well. It causes a
> > volume disparity and does not
> >    follow or even boost PCM signal. So it just a bad mister.
>
> Hm, the PCM volume should follow the master even in the current code.
> Doesn't the output volume change if you change the master volume (not
> mute)?
> Please check the AMP out value of the NID 0x04 in
> /proc/asound/card0/codec#*.  This corresponds to the PCM volume.
> Compare the values between master=100% and master=50%.
>
> > 2) it does not mute the volume (since PCM is the real master mixer you
> > have to go to PCM to mute the volume!)
>
> There is no PCM "switch" to mute.
> It's a known problem and the patch below should fix.
>
> > I have fixed a problem in Gstreamer so that Gnome (gnome volume mixer)
> > does finally work correctly for the AD1984 which does not have a
> > Master. When it looks for a master mixer it now will fallback to PCM
> > as a master mixer (the code is upsteam too). You can find this here:
> >
> > http://bugzilla.gnome.org/show_bug.cgi?id=506928
> >
> > I have a feeling this is why this patch was put in. I have fixed the
> > problem in Gnome, KDE has allways worked. just fine.
> >
> > But I would honestly love it if this code was removed!!! If you need a
> > Master can you rename PCM to master for the AD1984!
>
> PCM volume is no real master, unfortunately.  The analog loopbacks can
> be played regardless of PCM volume.  That's why it wasn't named as
> master at the first place.
>
> > I have attached a
> > patch to remove this code .. because it is so does not function well!
>
> (Can you stop! writing!! with!!! too much exclamation marks please?)
>
> It's nothing but a bug that I overlooked.
> Let's fix this more reasonablly.
>
>
> thanks,
>
> Takashi
>
> ---
>
> diff -r 303f894ac2a8 pci/hda/patch_analog.c
> --- a/pci/hda/patch_analog.c    Thu Jan 24 18:46:42 2008 +0100
> +++ b/pci/hda/patch_analog.c    Fri Jan 25 08:42:21 2008 +0100
> @@ -138,6 +138,7 @@ static const char *ad_slave_vols[] = {
>         "Side Playback Volume",
>         "Headphone Playback Volume",
>         "Mono Playback Volume",
> +       "Speaker Playback Volume",
>         NULL
>  };
>
> @@ -149,6 +150,7 @@ static const char *ad_slave_sws[] = {
>         "Side Playback Switch",
>         "Headphone Playback Switch",
>         "Mono Playback Switch",
> +       "Speaker Playback Switch",
>         NULL
>  };
>
>
