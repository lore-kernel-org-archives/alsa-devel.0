From: John Kacur <jkacur@redhat.com>
Subject: Re: WARNING: at sound/core/sound_oss.c:96 snd_oss_kernel_minor+0xdf/0x120
 	[snd]()
Date: Mon, 18 Jan 2010 15:48:29 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1001181543070.3781@localhost.localdomain>
References: <520f0cf11001060853i5c296744rf94c947cb7798774@mail.gmail.com> <s5hzl4j66pr.wl%tiwai@suse.de> <520f0cf11001180015ub28da4fp4c8c38d3c02c78d5@mail.gmail.com> <s5h1vhnps86.wl%tiwai@suse.de> <520f0cf11001180336k76fddf9u47c5ab316c7e42e5@mail.gmail.com>
 <s5hvdezo8y4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1323940160-1263826113=:3781"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753384Ab0AROsn@vger.kernel.org>
In-Reply-To: <s5hvdezo8y4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1323940160-1263826113=:3781
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 18 Jan 2010, Takashi Iwai wrote:

> At Mon, 18 Jan 2010 12:36:38 +0100,
> John Kacur wrote:
> > 
> > On Mon, Jan 18, 2010 at 12:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Mon, 18 Jan 2010 09:15:23 +0100,
> > > John Kacur wrote:
> > >>
> > >> On Tue, Jan 12, 2010 at 9:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > >> > At Wed, 6 Jan 2010 17:53:24 +0100,
> > >> > John Kacur wrote:
> > >> >>
> > >> >> The following was in my 2.6.33-rc3 dmesg (of course that doesn't mean
> > >> >> that the problem didn't exist earlier too)
> > >> >>
> > >> >> WARNING: at /home/jkacur/rt.linux.git/sound/core/sound_oss.c:96
> > >> >> snd_oss_kernel_minor+0xdf/0x120 [snd]()
> > >> >> Hardware name: 2241B48
> > >> >> BUG? (minor < 0 || minor >= 128)
> > >> >> Modules linked in: snd_mixer_oss thinkpad_acpi(+) sdhci hwmon i2c_i801
> > >> >> firewire_ohci snd_pcm mmc_core snd_timer cfg80211 firewire_core btusb
> > >> >> joydev iTCO_wdt bluetooth ata_generic e1000e i2c_core ppdev snd
> > >> >> battery ac iTCO_vendor_support parport_pc ricoh_mmc intel_agp
> > >> >> pata_acpi pcspkr parport tpm_tis video wmi output soundcore button tpm
> > >> >> rfkill sr_mod tpm_bios snd_page_alloc crc_itu_t cdrom sg ahci libata
> > >> >> sd_mod scsi_mod crc_t10dif xfs exportfs uhci_hcd ohci_hcd ehci_hcd
> > >> >> [last unloaded: scsi_wait_scan]
> > >> >> Pid: 1317, comm: modprobe Not tainted 2.6.33-rc3 #1
> > >> >> Call Trace:
> > >> >>  [<ffffffffa027bb25>] ? snd_oss_kernel_minor+0xdf/0x120 [snd]
> > >> >>  [<ffffffff8104338c>] warn_slowpath_common+0x7c/0xa9
> > >> >>  [<ffffffff81043410>] warn_slowpath_fmt+0x41/0x43
> > >> >>  [<ffffffffa027bb25>] snd_oss_kernel_minor+0xdf/0x120 [snd]
> > >> >>  [<ffffffffa027bc7e>] snd_register_oss_device+0x2c/0x21a [snd]
> > >> >>  [<ffffffffa0271e1e>] snd_mixer_oss_notify_handler+0xa5/0x2e5 [snd_mixer_oss]
> > >> >>  [<ffffffff81375e00>] ? __mutex_unlock_slowpath+0x5c/0x141
> > >> >>  [<ffffffff810710d5>] ? trace_hardirqs_on_caller+0x11f/0x14a
> > >> >>  [<ffffffff8107110d>] ? trace_hardirqs_on+0xd/0xf
> > >> >> sdhci-pci 0000:15:00.2: SDHCI controller found [1180:0822] (rev 21)
> > >> >> sdhci-pci 0000:15:00.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> > >> >>  [<ffffffff81375ed3>] ? __mutex_unlock_slowpath+0x12f/0x141
> > >> >> sdhci-pci 0000:15:00.2: Will use DMA mode even though HW doesn't fully
> > >> >> claim to support it.
> > >> >> Registered led device: mmc0::
> > >> >> mmc0: SDHCI controller on PCI [0000:15:00.2] using DMA
> > >> >>  [<ffffffffa027628a>] snd_card_register+0x135/0x14b [snd]
> > >> >>  [<ffffffffa0370c88>] volume_init+0x335/0x3d2 [thinkpad_acpi]
> > >> >>  [<ffffffffa037289b>] thinkpad_acpi_module_init+0x61f/0xa4f [thinkpad_acpi]
> > >> >>  [<ffffffffa037227c>] ? thinkpad_acpi_module_init+0x0/0xa4f [thinkpad_acpi]
> > >> >>  [<ffffffff810001fa>] do_one_initcall+0x5f/0x154
> > >> >>  [<ffffffff8107ff34>] sys_init_module+0xd7/0x234
> > >> >>  [<ffffffff81002d5b>] system_call_fastpath+0x16/0x1b
> > >> >> ---[ end trace a6d53dc318f09cb5 ]---
> > >> >
> > >> > Looks like the code path from thinkpad-acpi...
> > >> >
> > >> > Could you add some printk's in sound/core/sound_oss.c:snd_oss_kernel_minor()
> > >> > to inspect which values are taken and calculated?
> > >> >
> > >>
> > >> I'm getting a card->number equal to 29, and a dev equal to 0.
> > >
> > > The card number 29 is very strange.  Is it the correct number?
> > > You can see the sound instances in /proc/asound/cards.
> > >
> > >> The case is SNDRV_OSS_DEVICE_TYPE_MIXER:
> > >> So that does  minor = SNDRV_MINOR_OSS(card->number, (dev ?
> > >> SNDRV_MINOR_OSS_MIXER1 : SNDRV_MINOR_OSS_MIXER));
> > >> and according to the formula #define SNDRV_MINOR_OSS(card,
> > >> dev)  (((card) << 4) | (dev))
> > >> That works out to 464 which of course is not in the acceptable range
> > >> between 0 and 128.
> > >
> > > Do you build thinkpad-acpi as a module or built-in?  How about the
> > > sound stuff?
> > >
> > >
> > > Takashi
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > 
> >  cat /proc/asound/card
> > card0/  card29/ cards
> > [jkacur@tycho rt.linux.git]$ cat /proc/asound/cards
> >  0 [Intel          ]: HDA-Intel - HDA Intel
> >                       HDA Intel at 0xfc020000 irq 31
> > 29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
> >                       ThinkPad Console Audio Control at EC reg 0x30,
> > fw 7VHT12WW-1.01
> 
> OK, then the ALSA core driver behavior is correct.  But, another
> question is why such a strange number is passed.  Let me see the
> code...
> 
>  static int alsa_index = ~((1 << (SNDRV_CARDS - 3)) - 1); /* last three slots */
> 
> So, this behavior is intentional, too.

Okay, it took me a little bit to work it out that with SNDRV_CARDS = 32
the above is - the 29th bit. Kinda cryptic no?

Also, it does seem like the code intentionally makes use of that, at first
I was concerned you would be turning of a debug message for one use case,
but it seems consistent.

Even though the code looks obviously okay, I applied your patch, 
recompiled and booted, and the false message is gone.

Acked-by: John Kacur <jkacur@redhat.com>

Are you going to push that to Linus for 2.6.33?

Thank You.

> 
> In short, the warning message is just superfluous.
> The patch below fixes the issue.
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
> index 7fe1226..0c164e5 100644
> --- a/sound/core/sound_oss.c
> +++ b/sound/core/sound_oss.c
> @@ -93,7 +93,7 @@ static int snd_oss_kernel_minor(int type, struct snd_card *card, int dev)
>  	default:
>  		return -EINVAL;
>  	}
> -	if (snd_BUG_ON(minor < 0 || minor >= SNDRV_OSS_MINORS))
> +	if (minor < 0 || minor >= SNDRV_OSS_MINORS)
>  		return -EINVAL;
>  	return minor;
>  }
> 
--8323328-1323940160-1263826113=:3781--
