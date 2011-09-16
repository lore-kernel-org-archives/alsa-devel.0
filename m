From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
 checking for each DAIs separately
Date: Fri, 16 Sep 2011 11:02:11 +0800
Message-ID: <CAA+hA=TSP4aUmQEOAsWyuKFHsq45rAeTzbpEaFNeDM8vZHg9=g@mail.gmail.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E5E1285.8020508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 850CB103C86
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 05:02:12 +0200 (CEST)
Received: by yxk8 with SMTP id 8so2931323yxk.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 20:02:11 -0700 (PDT)
In-Reply-To: <4E5E1285.8020508@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Tabi Timur-B04825 <B04825@freescale.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

2011/8/31 Liam Girdwood <lrg@ti.com>:
> On 30/08/11 03:54, Dong Aisheng-B29396 wrote:
>>> -----Original Message-----
>>> From: Tabi Timur-B04825
>>> Sent: Tuesday, August 30, 2011 4:35 AM
>>> To: Dong Aisheng-B29396
>>> Cc: alsa-devel@alsa-project.org; lars@metafoo.de; s.hauer@pengutronix.d=
e;
>>> broonie@opensource.wolfsonmicro.com; w.sang@pengutronix.de; lrg@ti.com;
>>> linux-arm-kernel@lists.infradead.org
>>> Subject: Re: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
>>> checking for each DAIs separately
>>>
>>> On Mon, Aug 29, 2011 at 4:15 AM, Dong Aisheng <b29396@freescale.com>
>>> wrote:
>>>> The orginal code does not cover the case that one DAI such as codec
>>>> may be shared between other two DAIs(CPU).
>>>
>>> Can you give me an example of how this can occur?
>>>
>>
>> Pls check the following case used in mx28evk.
>> static struct snd_soc_dai_link mxs_sgtl5000_dai[] =3D {
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "HiFi Tx",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .stream_name =A0 =A0=3D "HiFi Playback",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_dai_name =3D "sgtl5000",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =A0 =A0 =3D "sgtl5000.0-000a=
",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .cpu_dai_name =A0 =3D "mxs-saif.0",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_name =A0=3D "mxs-pcm-audio.0",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &mxs_sgt=
l5000_hifi_ops,
>> =A0 =A0 =A0 =A0 }, {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "HiFi Rx",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .stream_name =A0 =A0=3D "HiFi Capture",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_dai_name =3D "sgtl5000",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .codec_name =A0 =A0 =3D "sgtl5000.0-000a=
",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .cpu_dai_name =A0 =3D "mxs-saif.1",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_name =A0=3D "mxs-pcm-audio.1",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0 =A0=3D &mxs_sgt=
l5000_hifi_ops,
>> =A0 =A0 =A0 =A0 },
>> };
>> You can also refer to:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/129789/focus=3D1298=
39
>>
>
> Timur, iirc your driver has some special symmetry requirement (maybe some=
thing todo with having 2 DAIs) ?
>
> I assume this is OK for you too ?
>
> Acked-by: Liam Girdwood <lrg@ti.com>
>
Can you apply this?

Regards
Dong Aisheng
