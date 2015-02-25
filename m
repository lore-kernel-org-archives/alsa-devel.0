From: Dang Sananikone <dang.sananikone@gmail.com>
Subject: Re: No sound and systemd journal filling when
 inserting headphones when power-saving is enabled
Date: Wed, 25 Feb 2015 22:15:32 +0000
Message-ID: <CAHRcCqCowXM4jmV9Hw8HuCABDCLD3skAxDZx7rUo_6qU9q2T0A@mail.gmail.com>
References: <loom.20150223T205312-191@post.gmane.org>
 <s5h4mqbe4hp.wl-tiwai@suse.de>
 <CAHRcCqBEEm41WWB+70JKduaZX2so4WVvH-YxKhduzfvR4VOh2g@mail.gmail.com>
 <s5hy4nn58pd.wl-tiwai@suse.de>
 <CAHRcCqDT1deCP805=Coq_gdQLmRJhVsPB1E4q=FESrZTwabS3A@mail.gmail.com>
 <s5hsidu5veq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 983452612BD
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 23:15:32 +0100 (CET)
Received: by labgd6 with SMTP id gd6so7145995lab.7
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 14:15:32 -0800 (PST)
In-Reply-To: <s5hsidu5veq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 25 February 2015 at 06:59, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 24 Feb 2015 22:26:32 +0000,
> Dang Sananikone wrote:
> >
> > On 24 February 2015 at 20:57, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Tue, 24 Feb 2015 20:11:58 +0000,
> > > Dang Sananikone wrote:
> > > >
> > > > Thanks, in that case I'll simply attach the files to this post.
> There are
> > > > two files:
> > > >
> > > >  * alsa-info-notworking.txt: This is the alsa info generated when
> > > > power-saving is enabled and after "speaker-test" has been invoked.
> > > >  * alsa-info-working.txt: This is the alsa info generated when
> > > power-saving
> > > > is disabled and after "speaker-test" has been invoked.
> > > >
> > > >
> > > > To reproduce the problem:
> > > >
> > > > Prerequisite:
> > > > Set "options snd_hda_intel power_save=1"
> > > >
> > > > Instructions:
> > > > 1. Boot up laptop.
> > > > 2. Insert headphone socket into jack.
> > > > 3. In terminal, type "speaker-test -c 2".
> > > >
> > > > Expected Result:
> > > > The speaker-test program hangs, and the systemd journal starts
> filling up
> > > > with "sound hdaudioC0D0: hda-codec: out of range cmd
> 0:1:716:ffffffff"
> > > > messages.
> > >
> > > OK, then try to pass power_save_controller=0 option to snd-hda-intel
> > > module.  It might be that the controller gets screwed up by some
> > > reason by power-saving.
> > >
> >
> > If I've understood you correctly I've set the following options: "options
> > snd_hda_intel power_save=1 power_save_controller=0".
> >
> > Then I've plugged in my headphones before invoking speaker-test. With no
> > audio playing I hear a blip sound every second.
>
> Every second?  Is this equal with the length you specified to
> power_save option?  i.e. if you pass power_save=10, the frequency of
> blip noise changes, too?
>

Yes, it is equal to the value specified in the power_save option. I changed
power_save to 10 and the frequency changed to 10 seconds.

>
> > Then I invoke "speaker-test -c 2" and I hear the speaker test audio I
> > expect to hear. The program does not hang. After killing the program and
> > with no audio playing I hear the blip sound every second.
>
> So, the problem was basically the HD-audio controller screwed up by
> the power-saving.  BTW, didn't you see the same problem with the
> explicit suspend/resume (S3 and S4)?  For testing it, try a bigger
> value in power_save so that you go to S3/S4 before the power save is
> triggered.
>
>
I set "options snd_hda_intel power_save=600", then performed the following
actions:

   * Reboot laptop.
   * Invoke "speaker-test -c 2", and wait for audio to play.
   * Enter suspend mode by calling "systemctl suspend" in another terminal
---> audio stops playing.
   * Exit suspend mode ---> audio restarts playing.

So, the same problem does not exist when entering/exiting suspend state.


> > > If this still doesn't help, we need more logs.  Build the kernel with
> > > tracing support, and get the HD-audio verb traces as
> > > Documentation/sound/alsa/HD-Audio.txt, section Tracepoints.
> > >
> > >
> > > Takashi
> > >
> >
> > Going back to this setting I set out to get the HD-audio verbs to provide
> > more information: "options snd_hda_intel power_save=1".
> >
> > I've attached the trace file which was generated after following your
> > instructions (I think the kernel already had tracing support enabled
> > judging by the /proc/config.gz config parameters).
>
> The trace already shows the bad read from the controller, so it's
> likely an issue in the HDA controller and/or communication.
>
> In anyway, below is a patch to disable runtime PM of the controller
> again.  It's equivalent as passing power_save_controller=1.  Could you
> give it a test?
>
>
>
I set "options snd_hda_intel power_save=1", then built and installed the
kernel with the patched file. Invoking "speaker-test -c 2" caused no
program hang and the audio was what I expected. Upon stopping the program I
could hear the periodic blip. Upon repeated test, sometimes there was a
periodic blip, sometimes there wasn't.


> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Disable runtime PM for Panther Point again
>
> This is essentially a partial revert of the commit [b1920c21102a:
> 'ALSA: hda - Enable runtime PM on Panther Point'].  There was a bug
> report showing the HD-audio bus hang during runtime PM on HP Spectre
> XT.
>
> Reported-by: Dang Sananikone <dang.sananikone@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 36d2f20db7a4..4ca3d5d02436 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1966,7 +1966,7 @@ static const struct pci_device_id azx_ids[] = {
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>         /* Panther Point */
>         { PCI_DEVICE(0x8086, 0x1e20),
> -         .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> +         .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>         /* Lynx Point */
>         { PCI_DEVICE(0x8086, 0x8c20),
>           .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
> --
> 2.3.0
>
>
