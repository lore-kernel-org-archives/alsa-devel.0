From: Taylor Smock <smocktaylor@gmail.com>
Subject: Re: Audio Jack Out does not work
Date: Wed, 08 Apr 2015 12:34:04 -0400
Message-ID: <1428510844.1169.8.camel@gmail.com>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
	 <20150407225642.GN16501@mwanda> <1428455226.1107.2.camel@gmail.com>
	 <s5hoamz6nd8.wl-tiwai@suse.de> <1428500098.907.2.camel@gmail.com>
	 <s5hy4m2n27y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy4m2n27y.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, perex@perex.cz, david.henningsson@canonical.com, joe@perches.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-04-08 at 16:06 +0200, Takashi Iwai wrote:
> At Wed, 08 Apr 2015 09:34:58 -0400,
> Taylor Smock wrote:
> > 
> > On Wed, 2015-04-08 at 10:22 +0200, Takashi Iwai wrote:
> > > At Tue, 07 Apr 2015 21:07:06 -0400,
> > > Taylor Smock wrote:
> > > > 
> > > > Yes; reverting the patch does fix the problem.
> > > 
> > > What if you just adjust the new volume manually without 
> > > reverting the
> > > patch?  Run "alsamixer -c0" (or -c1, depending on the setup).  
> > > Once
> > > after the setup, run "alsactl store" as root to save as the 
> > > system
> > > default volume.
> > > 
> > > The renamed volume should have been set in full volume as 
> > > default by
> > > the driver, and this shouldn't matter whether PA is new or old.  
> > > If
> > > the mixer adjustment isn't kept after relogin or reboot, it 
> > > means 
> > > that
> > > some user-space stuff overrides it.
> > > 
> > > In anyway, please give alsa-info.sh output before and after the
> > > commit.
> > > 
> > > 
> > > Takashi
> > > 
> > > > On Wed, 2015-04-08 at 01:56 +0300, Dan Carpenter wrote:
> > > > > So it's 03ad6a8c93b6df2 ('ALSA: hda - Fix "PCM" name being 
> > > > > used 
> > > > > on > one
> > > > > DAC when there are two DACs') which causes the problem?  
> > > > > Have 
> > > > > you 
> > > > > tried
> > > > > to just revert that patch?
> > > > > 
> > > > > git show 03ad6a8c93b6df2d65c305b5b5f9474068b45bfb | patch -
> > > > > p1 -R
> > > > > 
> > > > > regards,
> > > > > dan carpenter
> > > > > 
> > > > 
> > 
> > I ran alsamixer -c0.
> > Headphones did nothing.
> > Speaker+L0 did change headphone volume.
> 
> Please elaborate a bit what you're testing and what you expected.
> When you change "Headphone" volume and mute, it did nothing for which
> output?  "Speaker+LO" changes which output and which not?
> 
> You seem to have three outputs, one headphone jack on a laptop and 
> one
> on a docking station, and there is a built-in speaker.  Since your
> codec has only two DACs, two of three must be tied.
> 
> The bad thing is that BIOS pin configuration doesn't set the 
> headphone
> pin with the associate number 0x0f but only set it to the dock
> headphone.  Thus the driver assumes that the dock jack is the right
> headphone and handles the laptop headphone as a sub output.
> The commit you spotted took this difference more severely, and now 
> you
> see the unexpected mixer assignment.
> 
> So, the right "fix" would be rather to correct the pin config.
> For example, try the patch below.
> 
> (BTW, what is the product of your laptop model?  A more exact name 
> can
>  be filled in the quirk string.)
> 
> > PCM also seemed to affect headphone volume.
> 
> This is a mixer element added by alsa-lib softvol plugin, and it's 
> not
> what the kernel manages.
> 
> Judging from the description that this PCM volume affects, you are
> playing without PulseAudio but dmix, I suppose?
> 
> 
> Takashi
> 
> diff --git a/sound/pci/hda/patch_realtek.c 
> b/sound/pci/hda/patch_realtek.c
> index 7b5c93e0e78c..9d935e5c008a 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4429,6 +4429,7 @@ enum {
>       ALC269_FIXUP_QUANTA_MUTE,
>       ALC269_FIXUP_LIFEBOOK,
>       ALC269_FIXUP_LIFEBOOK_EXTMIC,
> +     ALC269_FIXUP_FUJITSU_HP_PIN,
>       ALC269_FIXUP_AMIC,
>       ALC269_FIXUP_DMIC,
>       ALC269VB_FIXUP_AMIC,
> @@ -4585,6 +4586,13 @@ static const struct hda_fixup alc269_fixups[] 
> = {
>                       { }
>               },
>       },
> +     [ALC269_FIXUP_FUJITSU_HP_PIN] = {
> +             .type = HDA_FIXUP_PINS,
> +             .v.pins = (const struct hda_pintbl[]) {
> +                     { 0x21, 0x0221102f }, /* HP out */
> +                     { }
> +             },
> +     },
>       [ALC269_FIXUP_AMIC] = {
>               .type = HDA_FIXUP_PINS,
>               .v.pins = (const struct hda_pintbl[]) {
> @@ -5105,6 +5113,7 @@ static const struct snd_pci_quirk 
> alc269_fixup_tbl[] = {
>       SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
>       SND_PCI_QUIRK(0x104d, 0x9099, "Sony VAIO S13", 
> ALC275_FIXUP_SONY_DISABLE_AAMIX),
>       SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
> +     SND_PCI_QUIRK(0x10cf, 0x15dc, "Fujitsu", 
> ALC269_FIXUP_FUJITSU_HP_PIN),
>       SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", 
> ALC269_FIXUP_LIFEBOOK_EXTMIC),
>       SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", 
> ALC269_FIXUP_INV_DMIC),
>       SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", 
> ALC283_FIXUP_BXBT2807_MIC),

I was testing a music player (Banshee) playing music, and I expected 
"Headphones" to control the audio output to my headphones.

If it is a BIOS pin configuration, then it is *probably* my fault, 
since I messed up my BIOS a few years ago.

The patch seems to work, assuming I reverted the change made to 
sound/pci/hda/hda_generic.c properly (git checkout 
sound/pci/hda/hda_generic.c) and applied the patch properly (git am 
SAVED_MBOX_FILE).

My laptop is a Fujitsu Lifebook T731. Unfortunately, the BIOS doesn't 
know that anymore.

I don't think I'm using dmix (I should be using pulseaudio, since a 
process is shown in ps aux | grep pulseaudio).
