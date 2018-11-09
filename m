From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei
	WMI micmute LED
Date: Fri, 9 Nov 2018 08:20:47 -0500
Message-ID: <CAB3uXr7-YW+yND1EC_wt8ptgnhUZLaYsoxJbs-vcWvOeEy6+Zw@mail.gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com> <s5hbm6y1v65.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E51BD267AB4
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 14:21:01 +0100 (CET)
Received: by mail-ua1-f68.google.com with SMTP id n7so599578uao.7
 for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2018 05:21:01 -0800 (PST)
In-Reply-To: <s5hbm6y1v65.wl-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 9, 2018, 4:01 AM Takashi Iwai <tiwai@suse.de wrote:

> On Thu, 08 Nov 2018 18:16:55 +0100,
> Ayman Bagabas wrote:
> >
> > diff --git a/drivers/platform/x86/huawei_wmi.c
> b/drivers/platform/x86/huawei_wmi.c
> > index 658c44ab2126..f06aa967c311 100644
> > --- a/drivers/platform/x86/huawei_wmi.c
> > +++ b/drivers/platform/x86/huawei_wmi.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/input.h>
> >  #include <linux/input/sparse-keymap.h>

>  #include <linux/module.h>
> > +#include <linux/platform_data/x86/huawei_wmi.h>
> >
> >  MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
> >  MODULE_DESCRIPTION("Huawei WMI hotkeys");
> > diff --git a/include/linux/platform_data/x86/huawei_wmi.h
> b/include/linux/platform_data/x86/huawei_wmi.h
> > new file mode 100644
> > index 000000000000..dd251780ee5c
> > --- /dev/null
> > +++ b/include/linux/platform_data/x86/huawei_wmi.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> > +#ifndef __HUAWEI_WMI_H__
> > +#define __HUAWEI_WMI_H__
> > +
> > +int huawei_wmi_micmute_led_set(bool on);
> > +
> > +#endif
> > +#endif
>
> These changes should belong to the WMI patch.
>
> > @@ -5765,6 +5769,10 @@ static const struct hda_fixup alc269_fixups[] = {
> >               .chained = true,
> >               .chain_id = ALC269_FIXUP_HEADSET_MIC
> >       },
> > +     [ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED] = {
> > +             .type = HDA_FIXUP_FUNC,
> > +             .v.func = alc_fixup_huawei_wmi
> > +     },
> >       [ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
> >               .type = HDA_FIXUP_PINS,
> >               .v.pins = (const struct hda_pintbl[]) {
> > @@ -5779,7 +5787,9 @@ static const struct hda_fixup alc269_fixups[] = {
> >                       {0x1e, 0x411111f0},
> >                       {0x21, 0x04211020},
> >                       { }
> > -             }
> > +             },
> > +             .chained = true,
> > +             .chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
> >       },
> >       [ALC269_FIXUP_ASUS_X101_FUNC] = {
> >               .type = HDA_FIXUP_FUNC,
>
> This means that ALC256_FIXUP_HUAWEI_MBXP_PINS performs both the pin
> config fixup and the mic-mute LED enablement.
>
> > @@ -6609,6 +6619,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = {
> >       SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad",
> ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> >       SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad",
> ALC298_FIXUP_TPT470_DOCK),
> >       SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad",
> ALC298_FIXUP_TPT470_DOCK),
> > +     SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX",
> ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
> >       SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP",
> ALC256_FIXUP_HUAWEI_MBXP_PINS),
> >       SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
> >       SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB",
> ALC269_FIXUP_LENOVO_EAPD),
>
> ... and yet you add a new entry for performing only mic-mute LED.
> I guess the chaining is done wrongly above?
>

They are suppose to be two different devices. MBXP should apply both, but
the MBX should only perform the LED. I'm also missing one entry for
(19e5:3201) that should apply to the LED, it's for the MBX too.

thanks,
>
> Takashi
>
