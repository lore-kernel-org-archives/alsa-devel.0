From: Randolph Chung <rchung42@gmail.com>
Subject: Re: [PATCH v2] Add support for tlv320aic3007 to
	tlv320aic3x codec.
Date: Fri, 20 Aug 2010 22:58:20 +0800
Message-ID: <AANLkTi=O=6WSje5dxytsO+EG6T2ksnyqw42PvZs12Kav@mail.gmail.com>
References: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
	<20100820110840.GF13668@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D1C0524548
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 16:58:23 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1277798iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 07:58:22 -0700 (PDT)
In-Reply-To: <20100820110840.GF13668@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> Applied but...
>
>> +static const struct i2c_device_id aic3x_i2c_id[] =3D {
>> + =A0 =A0 [AIC3X_MODEL_3X] =3D { "tlv320aic3x", 0 },
>> + =A0 =A0 [AIC3X_MODEL_33] =3D { "tlv320aic33", 0 },
>> + =A0 =A0 [AIC3X_MODEL_3007] =3D { "tlv320aic3007", 0 },
>> + =A0 =A0 { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
>
> The more idiomatic way to write this stuff is:
>
> =A0 =A0 =A0 =A0{ "tlv320aic3007", AIC3X_MODEL_3007 }
>
> and then look at the id field in the probe() function. =A0Could you send a
> followup patch doing that, please?

The second field in that struct is normally the i2c address, so this
seems a bit confusing...

randolph
