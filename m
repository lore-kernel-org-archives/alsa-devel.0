From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: wm9081: Use snd_soc_update_bits
	for read-modify-write
Date: Tue, 18 Oct 2011 09:43:12 +0800
Message-ID: <CAF+7xWkaQbfdOJ8_zWeyzctX4Ses64BtK7nHz4ubkLp1P_bV5g@mail.gmail.com>
References: <1318826212.12989.2.camel@phoenix>
	<20111017232547.GB2559@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1710C1038D5
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 03:43:34 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so169637bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 18:43:32 -0700 (PDT)
In-Reply-To: <20111017232547.GB2559@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/10/18 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Oct 17, 2011 at 12:36:52PM +0800, Axel Lin wrote:
>> Use snd_soc_update_bits for read-modify-write register access instead of
>> open-coding it using snd_soc_read and snd_soc_write
>
> Something in here is breaking audio through the WM9081 on Speyside. =A0I
> can't immediately spot anything wrong but the behaviour is quite obvious
> in the system.
>
hi Mark,
Thanks for testing.
I think the suspect part is here:

                        /* VMID 2*4k; Soft VMID ramp enable */
-                       reg =3D snd_soc_read(codec, WM9081_VMID_CONTROL);
-                       reg |=3D WM9081_VMID_RAMP | 0x6;
-                       snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
-
+                       snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+                                           WM9081_VMID_RAMP | 0x6,
+                                           WM9081_VMID_RAMP | 0x6);
                        mdelay(100);

                        /* Normal bias enable & soft start off */
-                       reg |=3D WM9081_BIAS_ENA;
-                       reg &=3D ~WM9081_VMID_RAMP;
-                       snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
+                       snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+                                           WM9081_VMID_RAMP | WM9081_BIAS_=
ENA,
+                                           WM9081_BIAS_ENA);

Original code does not change VMID_SEL[1:0] bits in the second write for
Normal bias enable & soft start off.

Maybe I should not convert it to snd_soc_update_bits for this case.

Regards,
Axel
