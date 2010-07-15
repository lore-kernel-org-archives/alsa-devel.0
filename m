From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 2/12] ak4642: fix a memory leak if failed to initialise
	AK4642
Date: Thu, 15 Jul 2010 14:19:02 +0800
Message-ID: <AANLkTilmp28xbK1Kja6YiA7DwlMpIBAyeOjTq2L1mR6o@mail.gmail.com>
References: <1279162147.29294.2.camel@mola> <1279162329.29294.6.camel@mola>
	<w3p4og1mgt3.wl%kuninori.morimoto.gx@renesas.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <w3p4og1mgt3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

2010/7/15 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Dear Axel
>
> Thanks about this patch
>
>> --- a/sound/soc/codecs/ak4642.c
>> +++ b/sound/soc/codecs/ak4642.c
>> @@ -491,8 +491,10 @@ static int ak4642_i2c_probe(struct i2c_client *=
i2c,
>> =A0 =A0 =A0 codec->control_data =3D i2c;
>>
>> =A0 =A0 =A0 ret =3D ak4642_init(ak4642);
>> - =A0 =A0 if (ret < 0)
>> + =A0 =A0 if (ret < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to initialise AK=
4642\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(ak4642);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>
> Indeed. this operation is needed when error case.
>
> I think
> i2c_set_clientdata(i2c, NULL); is needed here too.
> (da7210 also)

I think the i2c core will take care of it now.
see below commit log:
commit e4a7b9b04de15f6b63da5ccdd373ffa3057a3681
Author: Wolfram Sang <w.sang@pengutronix.de>
Date:   Tue May 4 11:09:27 2010 +0200

    i2c-core: Erase pointer to clientdata on removal

    After discovering that a lot of i2c-drivers leave the pointer to th=
eir
    clientdata dangling, it was decided to let the core handle this iss=
ue.
    It is assumed that the core may access the private data after remov=
e()
    as there are no guarantees for the lifetime of such pointers anyhow=
 (see
    thread starting at http://lkml.org/lkml/2010/3/21/68)

    Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
    Signed-off-by: Jean Delvare <khali@linux-fr.org>


>
> And why ak4642's patch doesn't have
> snd_soc_unregister_codec fix like da7210 ?
> I think ak4642 have same issue

In ak4642_init, current implementation will call
snd_soc_unregister_codec(codec);  before goto reg_cache_err;
Therefore, it should be no problem.

Or do you mean just using goto style cleanup instead of mixed
in-line and goto style cleanup?
I can fix it if you like this change.


Regards,
Axel

>
> Best regards
> --
> Kuninori Morimoto
>
>
