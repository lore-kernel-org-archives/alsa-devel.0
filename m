From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [REGRESSION] Sound goes too fast due to 798cb7e897210
Date: Tue, 18 Oct 2011 11:10:43 +0200
Message-ID: <4E9D4293.6040304@tremplin-utc.net>
References: <4E9D3466.5000901@tremplin-utc.net> <s5hzkgy1zf1.wl%tiwai@suse.de> <4E9D3AEE.6070809@tremplin-utc.net> <s5hty761ybk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hty761ybk.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, david.henningsson@canonical.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Op 18-10-11 10:46, Takashi Iwai schreef:
> At Tue, 18 Oct 2011 10:38:06 +0200,
> =C3=89ric Piel wrote:
>>
>> Op 18-10-11 10:23, Takashi Iwai schreef:
>>> At Tue, 18 Oct 2011 10:10:14 +0200,
>>> =C3=89ric Piel wrote:
>> :
>>> If that commit affects, the best fix would be to give a quirk speci=
fic
>>> to your device.  Try to pass either position_fix=3D1 or position_fi=
x=3D2.
>>> Only one of them should work (likely 2).
>>>
>>> After checking it, you can add it to position_fix_list[] in
>>> sound/pci/hda/hda_intel.c together with PCI SSID.
>>
>> Hello,
>> Thanks for the quick response. Indeed forcing position_fix=3D1 does =
fix
>> the bug. I'll not try to make a patch for my device.
>
> Hm, interesting.  So, in your case, the position-buffer exists and
> reports some valid values, but the values are sloppy actually.
> It's hard to detect in the driver, unfortunately.  The relevant commi=
t
> (and its original fix) were the attempts to detect better, but it
> seems that it fails...
>
> FWIW, the patch below is what I'm committing to the tree.
Thanks,
I've just tested it. It works like a charm :-)

=C3=89ric


>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai<tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Add position_fix quirk for Dell Inspiron=
 1010
>
> The previous fix for the position-buffer check gives yet another
> regression on a Dell laptop.  The safest fix right now is to add a
> static quirk for this device (and better to apply it for stable
> kernels too).
>
> Reported-by: =C3=89ric Piel<Eric.Piel@tremplin-utc.net>
> Cc:<stable@kernel.org>
> Signed-off-by: Takashi Iwai<tiwai@suse.de>
> ---
>   sound/pci/hda/hda_intel.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e9a2a87..191284a 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2370,6 +2370,7 @@ static int azx_dev_free(struct snd_device *devi=
ce)
>   static struct snd_pci_quirk position_fix_list[] __devinitdata =3D {
>   	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
>   	SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_LPIB),
> +	SND_PCI_QUIRK(0x1028, 0x02c6, "Dell Inspiron 1010", POS_FIX_LPIB),
>   	SND_PCI_QUIRK(0x103c, 0x306d, "HP dv3", POS_FIX_LPIB),
>   	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", POS_FIX_LPIB),
>   	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS", POS_FIX_LPIB),
