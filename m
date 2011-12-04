From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: uda1380: Return proper error in
 uda1380_modinit failure path
Date: Sun, 4 Dec 2011 21:44:27 +0800
Message-ID: <CAF+7xWmyfvZEbs5wHs=iO0Gna+_dDruxOJzUJzvT4WBpi1CugA@mail.gmail.com>
References: <1322998520.12391.1.camel@phoenix>
	<20111204130018.GA8461@sirena.org.uk>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B09624723
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 14:44:49 +0100 (CET)
Received: by lahe6 with SMTP id e6so1391152lah.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 05:44:48 -0800 (PST)
In-Reply-To: <20111204130018.GA8461@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

2011/12/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Dec 04, 2011 at 07:35:20PM +0800, Axel Lin wrote:
>
>> + =A0 =A0 int ret =3D 0;
>> =A0#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>> =A0 =A0 =A0 ret =3D i2c_add_driver(&uda1380_i2c_driver);
>> =A0 =A0 =A0 if (ret !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register UDA1380 I2C drive=
r: %d\n", ret);
>> =A0#endif
>> - =A0 =A0 return 0;
>> + =A0 =A0 return ret;
>
> In cases like this where only I2C is supported it's best to just remove
> all the ifdefs for I2C completely.

The datasheet says:
The UDA1380 supports I2C-bus microcontroller interface
mode as well as the L3-bus mode.
