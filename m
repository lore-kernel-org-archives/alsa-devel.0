From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH] ASoC: max98090 not need to return fail if fail to request
 hpdet irq.
Date: Wed, 30 Jul 2014 17:00:16 +0800
Message-ID: <53D8B420.9050504@rock-chips.com>
References: <1406685010-25108-1-git-send-email-xjq@rock-chips.com> <53D890C7.4080201@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53D890C7.4080201@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, tbleung@chromium.org, dgreid@chromium.org, kevin.strasser@intel.com, swarren@nvidia.com, ralph.birt@maximintegrated.com
Cc: heiko@sntech.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2014=E5=B9=B407=E6=9C=8830=E6=97=A5 14:29, Jarkko Nikula wrote:
> On 07/30/2014 04:50 AM, jianqun wrote:
>> From: xujianqun <xjq@rock-chips.com>
>>
>> Since hardware may not MUST to use IRQ pin of max98090 as jack detec=
t, the
>> driver can work well without it, can report jack trigger to CPU by a=
 GPIO.
>>
>> But here driver will register fail caused by failed to request irq.
>>
>> Signed-off-by: xujianqun <xjq@rock-chips.com>
>> ---
>>   sound/soc/codecs/max98090.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090=
=2Ec
>> index 566919c..bc124ff 100644
>> --- a/sound/soc/codecs/max98090.c
>> +++ b/sound/soc/codecs/max98090.c
>> @@ -2515,6 +2515,8 @@ static int max98090_probe(struct snd_soc_codec=
 *codec)
>>         max98090_add_widgets(codec);
>>   +    return 0;
>> +
>>   err_access:
>>       return ret;
>>   }
> I would say it's better to call request_threaded_irq() conditionally =
when max98090->irq is valid in the same max98090_probe(). Also code sho=
uld return instantly in case of request_threaded_irq() fails for valid =
irq.
>=20
> Now code is still printing needless error message in case max98090->i=
rq is invalid or not specified and continue probing in case request_thr=
eaded_irq() fails for valid irq.
>=20

Add a valid check could be better, thanks Jarkko~

I'm working a board with max98090, this is a really problem for me now,
the IRQ shouldn't cause the driver fail to register.

--=20
-------------
=E8=AE=B8 =E5=89=91 =E7=BE=A4 Jay
Rockchip Electronics Co.Ltd
***********************************************************************=
*****
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED=
=2E
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
***********************************************************************=
*****
