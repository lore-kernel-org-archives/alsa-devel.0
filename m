From: hwang4 <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - restore the gpio led after resume
Date: Mon, 18 Aug 2014 17:02:37 +0800
Message-ID: <53F1C12D.2030200@canonical.com>
References: <1408346720-3124-1-git-send-email-hui.wang@canonical.com> <s5hd2byw4tu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hd2byw4tu.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, franz.hsieh@canonical.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 2014=E5=B9=B408=E6=9C=8818=E6=97=A5 16:59, Takashi Iwai wrote:
> At Mon, 18 Aug 2014 15:25:19 +0800,
> Hui Wang wrote:
>> On some HP laptops, the mute led is controlled by codec gpio.
>>
>> When some machine resume from s3/s4, the codec gpio data will be
>> cleared to 0 by BIOS:
>> Before suspend:
>>    IO[3]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D1, unsol=
=3D0
>> After resume:
>>    IO[3]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D0, unsol=
=3D0
>>
>> To skip the AFG node to enter S3 can't fix this problem.
>>
>> A workaround is to restore the gpio data when the system resume
>> back from s3/s4. It is safe even on the machines without this
>> problem.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1358116
>> Tested-by: Franz Hsieh <franz.hsieh@canonical.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_rea=
ltek.c
>> index b32ce08..9c49bf5 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3432,6 +3432,12 @@ static unsigned int led_power_filter(struct h=
da_codec *codec,
>>   	    (nid !=3D spec->mute_led_nid && nid !=3D spec->cap_mute_led_n=
id))
>>   		return power_state;
>>  =20
>> +	if (nid =3D=3D codec->afg && power_state =3D=3D AC_PWRST_D0 && spe=
c->gpio_led) {
>> +		snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DATA,
>> +			    spec->gpio_led);
>> +		return power_state;
> In general, the power filter is a wrong place to put such a verb
> write.  This is called *before* powering up the codec NID.
Understand now.
>
> Yes, I see the pinctl is handled in the code below, and I don't like
> this either.  The codec write verb should be at best in the resume
> callback after power up.
OK, got it.

Thanks,
Hui.
>
> Takashi
>
>> +	}
>> +
>>   	/* Set pin ctl again, it might have just been set to 0 */
>>   	snd_hda_set_pin_ctl(codec, nid,
>>   			    snd_hda_codec_get_pin_target(codec, nid));
>> --=20
>> 1.9.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
