From: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/2 (v2)] ALSA: hda - Headset mic support
	for three more machines
Date: Wed, 12 Jun 2013 21:03:06 +0200
Message-ID: <CAH5Jhw_32z140DMkccSxTucZjotPdk1woMOxO--jAkJsuCKhHA@mail.gmail.com>
References: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A8A265141
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 21:03:07 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id r11so7964747lbv.27
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 12:03:07 -0700 (PDT)
In-Reply-To: <1370941609-5056-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, 1189363@bugs.launchpad.net, takashi.iwai@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi David,

I'm currently traveling, and will apply the patch in the weekend, as it
doesn't look like an urgent fix.

Thanks,

Takashi
On Jun 11, 2013 11:09 AM, "David Henningsson" <
david.henningsson@canonical.com> wrote:

> They need these quirks to have headset mic support.
>
> BugLink: https://bugs.launchpad.net/bugs/1189363
> Tested-by: Shawn Wang <shawn.wang@canonical.com>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> Note that this patch replaces the patch sent yesterday. I added one more
> ID in this version.
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 02e22b4..af9e71b 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -3483,6 +3483,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
> = {
>         SND_PCI_QUIRK(0x1028, 0x05ca, "Dell",
> ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05cb, "Dell",
> ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05de, "Dell",
> ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
> +       SND_PCI_QUIRK(0x1028, 0x05e0, "Dell",
> ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05e9, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05ea, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05eb, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
> @@ -3494,6 +3495,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
> = {
>         SND_PCI_QUIRK(0x1028, 0x05f5, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05f6, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x05f8, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
> +       SND_PCI_QUIRK(0x1028, 0x0606, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
> +       SND_PCI_QUIRK(0x1028, 0x0608, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x1028, 0x0609, "Dell",
> ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>         SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
>         SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
> --
> 1.7.9.5
>
>
