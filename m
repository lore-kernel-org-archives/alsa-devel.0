From: "Matt Mullins" <mokomull@gmail.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Wed, 20 Jun 2007 16:18:46 -0500
Message-ID: <dfd4051f0706201418o4d19a1f2g78081b052e8766e4@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<200706171149.27547.rjw@sisk.pl>
	<dfd4051f0706171355i7bc3d4b7qe9aee2acb904c8c@mail.gmail.com>
	<dfd4051f0706171735s72033440sf4d1dc83046e0e05@mail.gmail.com>
	<75b66ecd0706171749x1c29b4b2u8978ac68888960d@mail.gmail.com>
	<dfd4051f0706171859m721411bbvf9ac0352c8599a67@mail.gmail.com>
	<s5h1wg8i56k.wl%tiwai@suse.de>
	<dfd4051f0706191354i679c5b82pd8d788dfb012df3d@mail.gmail.com>
	<s5hvedjaq66.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4605A243D0
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 23:18:47 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so297644mue
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 14:18:46 -0700 (PDT)
In-Reply-To: <s5hvedjaq66.wl%tiwai@suse.de>
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

That doesn't seem to change anything.  Maybe I should have been more
clear: I get the azx_get_response timeouts whenever the driver
initializes; DMA never works for that codec.  single_cmd mode just
happens to work before a suspend, but not after.  In other words,
reloading the module doesn't really fix the problem, it just masks it
decently enough.   I'll work a little bit trying to figure out which
commands cause the timeouts.  And what *is* S2D?

Sorry about not CCing the mailing list, Gmail makes it way too easy to
do that, and too unnoticeable when it happens.  I'll be more careful.

On 6/20/07, Takashi Iwai <tiwai@suse.de> wrote:
> [Please don't strip Cc to ML!]
>
> At Tue, 19 Jun 2007 15:54:42 -0500,
> Matt Mullins wrote:
> >
> > I played around with probe_mask, and found that probe_mask=0x1 causes
> > the error, but probe_mask=0x2 does not cause the timeout.  Codec 1 is
> > my Sigmatel STAC9205, which is what plays sound on my laptop, and
> > codec 2 is my Conexant modem.  The modem isn't the codec causing
> > problems; the audio codec is!
>
> OK, good to know.  Does this problem occur with S2D?
> What is the very first command that triggers this timeout error?
>
> I'm wondering what is the difference between them -- according to your
> report, reloading the module fixes the problem.  But, the resume
> callback is almost identical with the re-initiailzation.
> Perhaps it's something to do with the power-state management.
> What about the patch below?
>
>
> Takashi
>
> diff -r c531d63e820b sound/pci/hda/hda_intel.c
> --- a/sound/pci/hda/hda_intel.c Wed Jun 20 12:03:09 2007 +0200
> +++ b/sound/pci/hda/hda_intel.c Wed Jun 20 12:09:40 2007 +0200
> @@ -1450,7 +1450,7 @@ static int azx_suspend(struct pci_dev *p
>                 pci_disable_msi(chip->pci);
>         pci_disable_device(pci);
>         pci_save_state(pci);
> -       pci_set_power_state(pci, pci_choose_state(pci, state));
> +       /* pci_set_power_state(pci, pci_choose_state(pci, state)); */
>         return 0;
>  }
>
>
