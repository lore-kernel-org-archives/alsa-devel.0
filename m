From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add Dell headset detection quirk for one
 more laptop model
Date: Tue, 17 Dec 2013 10:43:30 +0100
Message-ID: <52B01CC2.6040208@canonical.com>
References: <1387273183-11118-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1387273183-11118-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 10:39 AM, Hui Wang wrote:
> On the Dell machines with codec whose Subsystem Id is 0x10280640,
> no external microphone can be detected when plugging a 3-ring headset.
> If we add "model=dell-headset-multi" for the snd-hda-intel.ko, the
> problem will disappear.
> 
> The codec (Vendor ID: 0x10ec0255) on the machine belongs to alc_269
> family.
> 
> BugLink: https://bugs.launchpad.net/bugs/1260303
> Cc: David Henningsson <david.henningsson@canonical.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> This patch was generated against the master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> 
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 3578f11..4d7c602 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4309,6 +4309,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS),
>  	SND_PCI_QUIRK(0x1028, 0x063e, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1028, 0x0640, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),

Are you sure it shouldn't be ALC255_FIXUP_... in this line instead of
ALC269_FIXUP_... ?

>  	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
