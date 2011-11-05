From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH v2 RESEND] ASoC: wm9081: Use snd_soc_update_bits for read-modify-write
Date: Sat, 5 Nov 2011 14:46:55 +0800
Message-ID: <CAF+7xWntQUw6g7FD92iZm+D7ZS8dGG4=Q4SiHZRTkevbVrLCyg@mail.gmail.com>
References: <1318993587.7128.7.camel@phoenix> <20111104221730.GA16978@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104221730.GA16978@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/11/5 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Oct 19, 2011 at 11:06:27AM +0800, Axel Lin wrote:
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Normal bias enable & =
soft start off */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D WM9081_BIAS_ENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~WM9081_VMID_RAMP=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, WM908=
1_VMID_CONTROL, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec,=
 WM9081_VMID_CONTROL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_RAMP | WM9081_BIAS_ENA |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_SEL_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_BIAS_ENA);
>
> This looks (and sounds) wrong - the original code didn't touch
> VMID_SEL_MASK for this update but the new version will clear
> VMID_SEL_MASK. =A0Even with that fixed there still seems to be some i=
ssue
> here, though.
>

Hi Mark,

I just re-check current code, and I think current code (before converti=
ng to
snd_soc_update_bits) is broken.
See below 2 patches: ( I'm sending the patch now)
ASoC: wm9081: Fix reading wrong register for setting VMID 2*240k
ASoC: wm9081: Don't write WM9081_BIAS_ENA bit to WM9081_VMID_CONTROL re=
gister

Would you mind to test if above 2 patches works.
If it works, I'll send a new patch to use snd_soc_update_bits for
read-modify-write.

Thanks,
Axel
