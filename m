From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda/realtek - Add quirks for Dell
 Optiplex 5060, 7060 for audio out while using headphones
Date: Wed, 12 Dec 2018 09:09:00 +0800
Message-ID: <d898d4c8-ec8f-57f0-8f45-450c02ef9d8c@canonical.com>
References: <20181211224937.28889-1-gkumar@neverware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211224937.28889-1-gkumar@neverware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Girija Kumar Kasinadhuni <gkumar@neverware.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018/12/12 上午6:49, Girija Kumar Kasinadhuni wrote:
> There are two audio ports on these machines - headset and mic.
Looks like the two audio ports are headset and lineout.
> There' s no sound when hp is inserted into the headset port,
> though the hp is detected. Without pulseaudio, this issue is
> seen on both the Optiplex machines. The issue goes away with the
> "options snd-hda-intel model=dell-headset-dock" quirk in the
> /etc/modprobe.d/alsa-base.conf or /etc/modprobe.d/alsa.conf
> Getting this fix into the kernel instead of fixing in an
> application layer above, or in a .conf file. This is also helpful
> for audio clients using the ALSA api like cras from ChromiumOS.

Did you test audio playback and recording on two audio jacks after 
applying the patch?

And Node 0x16 of this codec is "Vendor Defined Widget", but the fixup 
will set it to "dock line out", it looks weird.

>
> Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
> ---
> alsa-info:
>
>   Optiplex 5060 -
>   - without fix:	http://www.alsa-project.org/db/?f=2cf3c4354e82bde4aa480612a914535982fa3f91
>   - with fix: http://www.alsa-project.org/db/?f=7a928960400ec828b82632411284ad8a63727b92
>   Optiplex 7060
>   - without fix: http://www.alsa-project.org/db/?f=69fa554faa712e7cad1f188be4a5192353d64f2c
>   - with fix: http://www.alsa-project.org/db/?f=80ce1fb178b377b27b0795ac1c55e8cbee1b5b96
>
>   sound/pci/hda/patch_realtek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 8d75597028ee..581f6a288abf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6444,6 +6444,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x0665, "Dell XPS 13", ALC288_FIXUP_DELL_XPS_13),
>   	SND_PCI_QUIRK(0x1028, 0x0669, "Dell Optiplex 9020m", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1028, 0x085b, "Dell Optiplex 5060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1028, 0x085a, "Dell Optiplex 7060", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x069a, "Dell Vostro 5480", ALC290_FIXUP_SUBWOOFER_HSJACK),
>   	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
