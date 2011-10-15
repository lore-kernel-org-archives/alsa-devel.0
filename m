From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: ad193x: Use snd_soc_update_bits
	for read-modify-write
Date: Sat, 15 Oct 2011 11:21:49 +0800
Message-ID: <CAF+7xWmdNqEuVCNB=53FftFm_Ds-=o5DwVa41MDq8m0DTZnzxg@mail.gmail.com>
References: <1318582919.19976.1.camel@phoenix>
	<1318582987.19976.2.camel@phoenix>
	<20111014191000.GB2931@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id B832E243E0
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 05:22:09 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so1917276bkb.38
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 20:22:09 -0700 (PDT)
In-Reply-To: <20111014191000.GB2931@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/10/15 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Oct 14, 2011 at 05:03:07PM +0800, Axel Lin wrote:
>
>> =A0 =A0 =A0 reg =3D snd_soc_read(codec, AD193X_DAC_CTRL2);
>> - =A0 =A0 reg =3D (mute > 0) ? reg | AD193X_DAC_MASTER_MUTE : reg &
>> - =A0 =A0 =A0 =A0 =A0 =A0 (~AD193X_DAC_MASTER_MUTE);
>> + =A0 =A0 if (mute)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D AD193X_DAC_MASTER_MUTE;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~AD193X_DAC_MASTER_MUTE;
>> =A0 =A0 =A0 snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
>
> This is still using snd_soc_read() and snd_soc_write() (though it is a
> cleanup).
>
hi Mark,
One of the major reason that I do the convert to snd_soc_update_bits
is for better readability.
In this case, it seems ok to me with this change.
But if you prefer also convert it to snd_soc_update_bits, I can do it.
Let me know if I need to send a v2 for it.

Thanks,
Axel
