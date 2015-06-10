From: Adam Goode <adam@spicenitz.org>
Subject: Re: OPL3 on cmipci doesn't survive suspend/resume
Date: Wed, 10 Jun 2015 00:02:26 -0400
Message-ID: <CADN=WdpdVt4AiBn0qdnMXHbh5RBNT-Y4CGtDNXh1Trc-jF+ggw@mail.gmail.com>
References: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
 <s5hy4ka9mg9.wl-tiwai@suse.de> <s5hoal69jw2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B9E4F265846
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 06:02:47 +0200 (CEST)
Received: by obcej4 with SMTP id ej4so26755489obc.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 21:02:47 -0700 (PDT)
In-Reply-To: <s5hoal69jw2.wl-tiwai@suse.de>
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

On Wed, May 27, 2015 at 10:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 27 May 2015 15:31:02 +0200,
> Takashi Iwai wrote:
>>
>> At Wed, 27 May 2015 09:23:17 -0400,
>> Adam Goode wrote:
>> >
>> > Hi,
>> >
>> > I have this card:
>> >
>> > 05:00.0 Multimedia audio controller: C-Media Electronics Inc
>> > CMI8738/CMI8768 PCI Audio (rev 10)
>> > Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
>> > Flags: bus master, stepping, medium devsel, latency 32, IRQ 19
>> > I/O ports at d000 [size=256]
>> > Capabilities: [c0] Power Management version 2
>> > Kernel driver in use: snd_cmipci
>> > Kernel modules: snd_cmipci
>> >
>> >
>> > When I suspend/resume, the sound from the OPL3 is permanently
>> > distorted. It sounds like not all of the operators are active. I can
>> > fix this by doing a full PCI remove/rescan cycle: the driver correctly
>> > initializes the card at this time.
>> >
>> > Any ideas before I peek into the code?
>>
>> OPL3 stuff lacks of PM code completely.  Maybe calling snd_opl3_init()
>> again should enable the minimal stuff.
>
> That said, a patch like below.  The whole synth setup still needs to
> be reset, I suppose.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
> index 6cf464d9043d..f03fd5f2e043 100644
> --- a/sound/pci/cmipci.c
> +++ b/sound/pci/cmipci.c
> @@ -498,6 +498,8 @@ struct cmipci {
>         /* external MIDI */
>         struct snd_rawmidi *rmidi;
>
> +       struct snd_opl3 *opl3;
> +
>  #ifdef SUPPORT_JOYSTICK
>         struct gameport *gameport;
>  #endif
> @@ -3005,6 +3007,7 @@ static int snd_cmipci_create_fm(struct cmipci *cm, long fm_port)
>                 dev_err(cm->card->dev, "cannot create OPL3 hwdep\n");
>                 return err;
>         }
> +       cm->opl3 = opl3;
>         return 0;
>
>   disable_fm:
> @@ -3386,6 +3389,8 @@ static int snd_cmipci_resume(struct device *dev)
>         for (i = 0; i < ARRAY_SIZE(saved_mixers); i++)
>                 snd_cmipci_mixer_write(cm, saved_mixers[i], cm->saved_mixers[i]);
>
> +       if (cm->opl3)
> +               snd_opl3_init(cm->opl3);
>         snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>         return 0;
>  }


Yes, it is better with this patch. I still get the same distorted
sounds after resume, but a subsequent sbiload will restore the
instruments correctly. Before the patch, sbiload had no effect and I
had to remove/rescan the card..

Ideally, suspend/resume would restore the patches so that sbiload
would not be necessary. But this is exactly as urgent as it seems. :)


Thanks,

Adam
