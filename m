From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH v3] ASoC: wm9081: Use snd_soc_update_bits
	for read-modify-write
Date: Wed, 9 Nov 2011 16:46:22 +0800
Message-ID: <CAF+7xW=uozfkCEfozZFmVzkbC+6S5UX-9n2woF9CCGxj5_tmFA@mail.gmail.com>
References: <1320827885.6708.1.camel@phoenix>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8301C1039C0
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 09:46:43 +0100 (CET)
Received: by faaa20 with SMTP id a20so1535452faa.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Nov 2011 00:46:43 -0800 (PST)
In-Reply-To: <1320827885.6708.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* VMID 2*4k; Soft VMID ra=
mp enable */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D snd_soc_read(codec,=
 WM9081_VMID_CONTROL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D WM9081_VMID_RAMP |=
 0x6;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, WM9081=
_VMID_CONTROL, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, =
WM9081_VMID_CONTROL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_RAMP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_SEL_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_RAMP | 0x6);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(100);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Normal bias enable & so=
ft start off */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~WM9081_VMID_RAMP;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, WM9081=
_VMID_CONTROL, reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, =
WM9081_VMID_CONTROL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_RAMP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 WM9081_VMID_SEL_MASK, 0);
>
It's probably not trival why we need to clear WM9081_VMID_SEL_MASK bits her=
e by
looking at the patch.  Looking at original code, you will know current code
indeed clear WM9081_VMID_SEL_MASK bit here.

What current code does:
        1. read WM9081_VMID_CONTROL register
        2. write to WM9081_VMID_CONTROL register with setting WM9081_VMID_R=
AMP
           bit and setting WM9081_VMID_SEL_MASK bits to 0x6 (VMID
2*4k; Soft VMID
           ramp enable)
        3. mdelay(100)
        4. write to WM9081_VMID_CONTROL register with clearing
WM9081_VMID_RAMP bit.
           Note: In this write, we do also clear WM9081_VMID_SEL_MASK
bits because the register
           value of WM9081_VMID_SEL_MASK bits are clear when we read
in "step1".
           In this case, the WM9081_VMID_SEL_MASK bits are clear
           because we clear WM9081_VMID_SEL_MASK bits in SND_SOC_BIAS_OFF.
           ( The default value is also zero for WM9081_VMID_SEL_MASK bits. )

While converting to snd_soc_update_bits here we actually do one more read.
For the second call of snd_soc_update_bits, we need to explictly clear
WM9081_VMID_SEL_MASK bits.

Regards,
Axel
