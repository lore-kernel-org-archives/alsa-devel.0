From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH 2/9] ASoC: max98927: Added controls for Envelope tracking
Date: Fri, 1 Sep 2017 21:38:13 +0000
Message-ID: <BY2PR11MB083746D8B7157462EDB24861E7920@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
 <1503963061-14763-2-git-send-email-ryans.lee@maximintegrated.com>
 <20170831114357.dekzz4wa7j6vqi4t@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831114357.dekzz4wa7j6vqi4t@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Thursday, August 31, 2017 4:44 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
>kuninori.morimoto.gx@renesas.com; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH 2/9] ASoC: max98927: Added controls for Envelope track=
ing
>
>On Mon, Aug 28, 2017 at 04:30:54PM -0700, Ryan Lee wrote:
>
>>  	/* Envelope Tracking configuration */
>>  	regmap_write(max98927->regmap,
>>  		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
>> -		0x08);
>> +		0x0A);
>>  	regmap_write(max98927->regmap,
>>  		MAX98927_R0086_ENV_TRACK_CTRL,
>>  		0x01);
>> -	regmap_write(max98927->regmap,
>> -		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
>> -		0x10);
>
>Why are we changing the defaults here?  It was understandable to have a fi=
xed
>default that differed from the chip value when there was no control but no=
w
>there is a control and we're changing the default again for some undocumen=
ted
>reason.  It'd be better to leave the values here to avoid breaking compati=
bility
>with existing users and let users who need different values change things =
using
>the newly added controls.

Thank you for feedback. Let me keep existing value.
I still need to remove regmap_write for R:0x87 because it is read-only regi=
ster.
