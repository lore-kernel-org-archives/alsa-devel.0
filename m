From: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv3 2/2] ALSA: hda - Add driver for Tegra SoC HDA
Date: Fri, 18 Apr 2014 14:32:54 -0700
Message-ID: <CAEUnVG71Bo=4CMDFR2q3=6qC=HsG+-dctxDpR4y6Fd+pXZgFDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2014 at 1:22 AM, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org> wrote:
> At Wed, 16 Apr 2014 14:39:32 -0700,
> Dylan Reid wrote:
>>
>> This adds a driver for the HDA block in Tegra SoCs.  The HDA bus is
>> used to communicate with the HDMI codec on Tegra124.
>>
>> Most of the code is re-used from the Intel/PCI HDA driver.  It brings
>> over only the power_save module parameter.
>>
>> Signed-off-by: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Thanks, this looks better, but a few comments below.
> Besides, I'd like to have a review in DT part.


Thanks for looking.  I'll address the comments below and send a v4
with some more DT maintainers CCed.

>
>
>> +/*
>> + * Register access ops. Tegra HDA register access is DWORD only.
>> + */
>> +static void hda_tegra_writel(u32 value, u32 *addr)
>> +{
>> +     writel(value, addr);
>> +}
>> +
>> +static u32 hda_tegra_readl(u32 *addr)
>> +{
>> +     return readl(addr);
>> +}
>> +
>> +static void hda_tegra_writew(u16 value, u16 *addr)
>> +{
>> +     unsigned long shift = ((uintptr_t)(addr) & 0x3) << 3;
>> +     void *dword_addr = (void *)((uintptr_t)(addr) & ~0x3);
>> +     u32 v;
>> +
>> +     v = readl(dword_addr);
>> +     v &= ~(0xffff << shift);
>> +     v |= value << shift;
>> +     writel(v, dword_addr);
>> +}
>
> The shift doesn't have to be long at all, and the cast in kernel is
> usually just unsigned long instead of uintptr_t.
>
>
>> +#ifdef CONFIG_PM_SLEEP
>> +/*
>> + * power management
>> + */
>> +static int hda_tegra_suspend(struct device *dev)
>> +{
>> +     struct snd_card *card = dev_get_drvdata(dev);
>> +     struct azx *chip = card->private_data;
>> +     struct azx_pcm *p;
>> +     struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
>> +
>> +     snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>> +     list_for_each_entry(p, &chip->pcm_list, list)
>> +             snd_pcm_suspend_all(p->pcm);
>> +     if (chip->initialized)
>> +             snd_hda_suspend(chip->bus);
>> +
>> +     /* enable controller wake up event */
>> +     azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
>> +               STATESTS_INT_MASK);
>
> I guess WAKEEN doesn't work for Tegra?

I'm unsure, but this doesn't belong in the regular resume path, so it
will disappear in v4.

>
>> +
>> +     azx_stop_chip(chip);
>> +     azx_enter_link_reset(chip);
>> +     hda_tegra_disable_clocks(hda);
>> +
>> +     return 0;
>> +}
>> +
>> +static int hda_tegra_resume(struct device *dev)
>> +{
>> +     struct snd_card *card = dev_get_drvdata(dev);
>> +     struct azx *chip = card->private_data;
>> +     struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
>> +     int status;
>> +     struct hda_codec *codec;
>> +
>> +     hda_tegra_enable_clocks(hda);
>> +
>> +     /* Read STATESTS before controller reset */
>> +     status = azx_readw(chip, STATESTS);
>> +
>> +     hda_tegra_init(hda);
>> +
>> +     if (status && chip->bus) {
>> +             list_for_each_entry(codec, &chip->bus->codec_list, list)
>> +                     if (status & (1 << codec->addr))
>> +                             queue_delayed_work(codec->bus->workq,
>> +                                                &codec->jackpoll_work,
>> +                                                codec->jackpoll_interval);
>> +     }
>
> This is superfluous for the regular resume.  It was some missing call
> only in the runtime resume.
>
>> +
>> +     /* disable controller Wake Up event*/
>> +     azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) & ~STATESTS_INT_MASK);
>
> This can be removed like the suspend.
>
>
> thanks,
>
> Takashi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
