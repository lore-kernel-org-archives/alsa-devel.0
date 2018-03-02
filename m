From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Fri, 2 Mar 2018 10:32:25 +0100
Message-ID: <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
 <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 86F82267CCC
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 10:32:27 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id t6so1829310wmt.5
 for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2018 01:32:27 -0800 (PST)
In-Reply-To: <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 01-03-18 23:35, Hans de Goede wrote:
> Hi,
> =

> On 01-03-18 20:30, Mark Brown wrote:
>> On Sun, Feb 25, 2018 at 11:46:47AM +0100, Hans de Goede wrote:
>>> Configure the jack-detect source through a device-property which can be
>>> set by code outside of the codec driver. Rather then putting platform
>>> specific DMI quirks inside the generic codec driver.
>>
>>> And move the jack-detect-source quirk for the KIANO SlimNote 14.2, which
>>> was present inside the codec driver to the machine driver, where we can
>>> bundle it together with the other quirks already present for this lapto=
p.
>>
>> Multiple things in a patch again :/
> =

> Yes because the property replaces the quirk, I can split the changes betw=
een
> the codec and machine driver into 2 patches but then the intermediate sta=
te
> will be that the jack-detection no longer works.
> =

>> The property itself is fine but...
>>
>>> @@ -360,6 +377,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runt=
ime *runtime)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(card->dev, "unable to s=
et MCLK rate\n");
>>> =A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 props[cnt++] =3D PROPERTY_ENTRY_U32("realtek,jack-detect-sou=
rce",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BYT_RT5651_JDSRC(byt_rt5=
651_quirk));
>>> +
>>> +=A0=A0=A0 ret =3D device_add_properties(codec->dev, props);
>>> +=A0=A0=A0 if (ret)
>>> +=A0=A0=A0=A0=A0=A0=A0 return ret;
>>> +
>>> =A0=A0=A0=A0=A0 ret =3D snd_soc_card_jack_new(runtime->card, "Headset",
>>
>> I'm having a hard time geting comfortable with this; it's all a bit
>> fragile feeling to me - someone deciding to centralise the property
>> parsing (eg, if they are using a platform where platform data makes
>> sense or want to cross-validate with some other property on probe) could
>> easily break things and there's not even a comment in the CODEC driver.
> =

> It is not _that_ fragile, but I agree that it would be good to add
> a comment about not moving the property-parsing to the codec driver.

So one other solution which comes to mind here is to move the
snd_soc_card_jack_new() call into the codec driver's
rt5651_apply_properties() function (conditional on a jack src being
set in the properties).

This would make the machine driver code look like this:

	props[cnt++] =3D PROPERTY_ENTRY_...
	props[cnt++] =3D PROPERTY_ENTRY_...
	props[cnt++] =3D PROPERTY_ENTRY_...
	props[cnt++] =3D PROPERTY_ENTRY_...

	ret =3D device_add_properties(codec->dev, props);
	if (ret)
		return ret;

	ret =3D rt5651_apply_properties(codec);
	if (ret)
		return ret;

Which makes the ordering really clear without needing any
comments.

This will also make the jack-detect device-properties work with
devicetree platforms without any changes to their platform code,
which currently is not the case since the non Intel platform-code
does not call snd_soc_component_set_jack().

Thinking more about this I believe that doing the
snd_soc_card_jack_new() call inside the codec driver based on
device-properties is a better solution then doing it in the
machine driver.

Please let me know if you agree then I will rework the remaining
patches accordingly.

Regards,

Hans
