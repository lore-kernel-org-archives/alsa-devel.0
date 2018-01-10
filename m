From: "Francisco G." <frangio.1@gmail.com>
Subject: Re: snd_hda_intel: coil whine noises after resume
Date: Wed, 10 Jan 2018 01:42:40 -0300
Message-ID: <CAHXyb9YXTX5Tf=QDqjf=S37N3H=oGbU1LU81WCHyGUn82aqT7w@mail.gmail.com>
References: <CAHXyb9ZCZJzVisuBARa+UORcjRERV8yokez=DP1_5O5isTz0ZA@mail.gmail.com>
 <s5hbmi31lag.wl-tiwai@suse.de>
 <CAHXyb9aQxyJRtMMWnd9NU1WJzxy+n6Pe7-6FEjM_fvv+hsbDfg@mail.gmail.com>
 <s5hr2qz2fvh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE3F72674CE
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 05:42:57 +0100 (CET)
Received: by mail-yw0-f193.google.com with SMTP id g191so6561019ywe.7
 for <alsa-devel@alsa-project.org>; Tue, 09 Jan 2018 20:42:57 -0800 (PST)
In-Reply-To: <s5hr2qz2fvh.wl-tiwai@suse.de>
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

I can confirm the patch fixes the issue.

On Tue, Jan 9, 2018 at 12:47 PM, Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 09 Jan 2018 16:10:51 +0100,
> Francisco G. wrote:
> >
> > Thanks Takashi. Here's the output: https://pastebin.com/z9uFY8Zt
> >
> > The SSID seems to be 1028:082a.
>
> OK, then could you try the patch below?  It just reuses the existing
> quirk for another XPS13 variants.
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 440972975bd4..93d2ce891db6 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6295,6 +6295,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
> = {
>         SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360",
> ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
>         SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
>         SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming",
> ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
> +       SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360",
> ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
>         SND_PCI_QUIRK(0x1028, 0x164a, "Dell",
> ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x164b, "Dell",
> ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2)
> ,
>
