From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH v3] ASoC: wm9081: Use snd_soc_update_bits
	for read-modify-write
Date: Wed, 9 Nov 2011 16:53:18 +0800
Message-ID: <CAF+7xW=JQBxV5A_3p6HrybetFq-kQAX-XRzQDAF7ebPApA_gnw@mail.gmail.com>
References: <1320827885.6708.1.camel@phoenix>
	<CAF+7xW=uozfkCEfozZFmVzkbC+6S5UX-9n2woF9CCGxj5_tmFA@mail.gmail.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C5C951039C9
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 09:53:39 +0100 (CET)
Received: by faaa20 with SMTP id a20so1540880faa.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Nov 2011 00:53:39 -0800 (PST)
In-Reply-To: <CAF+7xW=uozfkCEfozZFmVzkbC+6S5UX-9n2woF9CCGxj5_tmFA@mail.gmail.com>
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

2011/11/9 Axel Lin <axel.lin@gmail.com>:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* VMID 2*4k; Soft VMID r=
amp enable */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D snd_soc_read(codec=
, WM9081_VMID_CONTROL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D WM9081_VMID_RAMP =
| 0x6;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, WM908=
1_VMID_CONTROL, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec,=
 WM9081_VMID_CONTROL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 WM9081_VMID_RAMP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 WM9081_VMID_SEL_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 WM9081_VMID_RAMP | 0x6);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mdelay(100);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Normal bias enable & s=
oft start off */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~WM9081_VMID_RAMP;

oh.. wait. so original code does not clear WM9081_VMID_SEL_MASK bits here.
My bad. Don't know why I always think WM9081_VMID_SEL_MASK bits are
cleared here.

Will send a new version soon.

>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, WM908=
1_VMID_CONTROL, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec,=
 WM9081_VMID_CONTROL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 WM9081_VMID_RAMP |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 WM9081_VMID_SEL_MASK, 0);
>>
