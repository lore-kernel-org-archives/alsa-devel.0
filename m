From: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: RE: [v2] ASoC: max98373: Added Amplifier Driver
Date: Wed, 3 Jan 2018 18:37:09 +0000
Message-ID: <BY2PR11MB083710A6A737AB9C862FC965E71E0@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1514214610-17630-1-git-send-email-ryans.lee@maximintegrated.com>
 <20171226233307.hdjxi5ntt7c5i2v4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226233307.hdjxi5ntt7c5i2v4@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "afd-l0cyMroinI0@public.gmane.org" <afd-l0cyMroinI0@public.gmane.org>, "robert.jarzmik-GANU6spQydw@public.gmane.org" <robert.jarzmik-GANU6spQydw@public.gmane.org>, "supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "dannenberg-l0cyMroinI0@public.gmane.org" <dannenberg-l0cyMroinI0@public.gmane.org>, "romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org" <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org" <bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "m-stecklein-l0cyMroinI0@public.gmane.org" <m-stecklein-l0cyMroinI0@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


>-----Original Message-----
>From: Rob Herring [mailto:robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
>Sent: Tuesday, December 26, 2017 3:33 PM
>To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
>perex-/Fr2/VpizcU@public.gmane.org; tiwai-IBi9RG/b67k@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org; afd-l0cyMroinI0@public.gmane.org;
>robert.jarzmik-GANU6spQydw@public.gmane.org; supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org;
>dannenberg-l0cyMroinI0@public.gmane.org; romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org;
>bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org; kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org; m-
>stecklein-l0cyMroinI0@public.gmane.org; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ryan.lee.maxim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>Subject: Re: [v2] ASoC: max98373: Added Amplifier Driver
>
>EXTERNAL EMAIL
>
>
>
>On Mon, Dec 25, 2017 at 07:10:10AM -0800, Ryan Lee wrote:
>
>Needs a commit message.
>
>> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>> ---
>>
>> Changes since v1:
>>       * Removed 'codec' from 'max98373_priv' structure
>>               : Now 'max98373_set_clock' function use 'dai->codec.dev' i=
nstead of
>using 'max98373->codec.dev'.
>>       * Removed 'max98373_dai_set_sysclk' function
>>               : This function is not necessary. Removed 'sysclk' from
>'max98373_priv' as well.
>>       * Removed 'iface' from 'max98373_priv' structure
>>               : There is no function who refer max98373->iface variable.
>>       * Added SPDX-License-Identifier
>>
>>  .../devicetree/bindings/sound/max98373.txt         |  43 +
>
>Please split bindings to separate patch.
Thank you for the feedback.
I will split it.

>
>>  sound/soc/codecs/Kconfig                           |   5 +
>>  sound/soc/codecs/Makefile                          |   2 +
>>  sound/soc/codecs/max98373.c                        | 974
>+++++++++++++++++++++
>>  sound/soc/codecs/max98373.h                        | 212 +++++
>>  5 files changed, 1236 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/sound/max98373.txt
>>  create mode 100644 sound/soc/codecs/max98373.c  create mode 100644
>> sound/soc/codecs/max98373.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/max98373.txt
>> b/Documentation/devicetree/bindings/sound/max98373.txt
>> new file mode 100644
>> index 0000000..22cd259
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/max98373.txt
>> @@ -0,0 +1,43 @@
>> +Maxim Integrated MAX98373 Speaker Amplifier
>> +
>> +This device supports I2C.
>> +
>> +Required properties:
>> +
>> +  - compatible : should be one of the following
>> +    - "maxim,max98373"
>> +
>> +  - reg : the I2C address of the device.
>> +
>> +Optional properties:
>> +
>> +  - maxim,vmon-slot-no : slot number used to send voltage information
>> +                   or in inteleave mode this will be used as
>> +                   interleave slot.
>> +                   slot range : 0 ~ 15,  Default : 0
>> +
>> +  - maxim,imon-slot-no : slot number used to send current information
>> +                   slot range : 0 ~ 15,  Default : 0
>> +
>> +  - maxim,spkfb-slot-no : slot number used to send speaker feedback
>information
>> +                   slot range : 0 ~ 15,  Default : 0
>> +
>> +  - maxim,interleave-mode : When using two MAX98373 in a system it is
>> +                   possible to create ADC data that that will
>> +                   overflow the frame size. Digital Audio Interleave
>> +                   mode provides a means to output VMON and IMON data
>> +                   from two devices on a single DOUT line when running
>> +                   smaller frames sizes such as 32 BCLKS per LRCLK or
>> +                   48 BCLKS per LRCLK.
>> +                   Range : 0 (off), 1 (on),  Default : 0
>
>This can be boolean instead.
I will change this to boolean type.
>
>> +
>> +Example:
>> +
>> +codec: max98373@31 {
>> +   compatible =3D "maxim,max98373";
>> +   reg =3D <0x31>;
>> +   maxim,vmon-slot-no =3D <0>;
>> +   maxim,imon-slot-no =3D <1>;
>> +   maxim,spkfb-slot-no =3D <2>;
>> +   maxim,interleave-mode =3D <0>;
>> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
