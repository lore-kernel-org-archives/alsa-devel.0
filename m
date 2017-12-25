From: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH] ASoC: max98373: Added Amplifier Driver
Date: Mon, 25 Dec 2017 14:30:23 +0000
Message-ID: <BY2PR11MB0837C049BCA0C1B5103EA3FBE7010@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1513907030-18441-1-git-send-email-ryans.lee@maximintegrated.com>
 <87a7ybo6em.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a7ybo6em.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "afd-l0cyMroinI0@public.gmane.org" <afd-l0cyMroinI0@public.gmane.org>, "robert.jarzmik-GANU6spQydw@public.gmane.org" <robert.jarzmik-GANU6spQydw@public.gmane.org>, "supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "dannenberg-l0cyMroinI0@public.gmane.org" <dannenberg-l0cyMroinI0@public.gmane.org>, "romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org" <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org" <bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, "m-stecklein-l0cyMroinI0@public.gmane.org" <m-stecklein-l0cyMroinI0@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-u79uwXL29TbrhsbdSgBK9A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Kuninori Miromoto,

>-----Original Message-----
>From: Kuninori Morimoto [mailto:kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org]
>Sent: Thursday, December 21, 2017 6:24 PM
>To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
>mark.rutland-5wv7dgnIgG8@public.gmane.org; perex-/Fr2/VpizcU@public.gmane.org; tiwai-IBi9RG/b67k@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
>afd-l0cyMroinI0@public.gmane.org; robert.jarzmik-GANU6spQydw@public.gmane.org; supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
>jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org; dannenberg-l0cyMroinI0@public.gmane.org; romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org;
>bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org; m-stecklein-l0cyMroinI0@public.gmane.org; alsa-devel@alsa-
>project.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>ryan.lee.maxim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>Subject: Re: [PATCH] ASoC: max98373: Added Amplifier Driver
>
>EXTERNAL EMAIL
>
>
>
>Hi Ryan
>
>> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
>> ---
>>
>> Created max98373 amplifier driver.
>>
>>  .../devicetree/bindings/sound/max98373.txt         |  43 +
>>  sound/soc/codecs/Kconfig                           |   5 +
>>  sound/soc/codecs/Makefile                          |   2 +
>>  sound/soc/codecs/max98373.c                        | 996
>+++++++++++++++++++++
>>  sound/soc/codecs/max98373.h                        | 225 +++++
>>  5 files changed, 1271 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/sound/max98373.txt
>>  create mode 100644 sound/soc/codecs/max98373.c  create mode 100644
>> sound/soc/codecs/max98373.h
>(snip)
>> +struct max98373_priv {
>> +     struct regmap *regmap;
>> +     struct snd_soc_codec *codec;
>> +     unsigned int sysclk;
>> +     unsigned int v_slot;
>> +     unsigned int i_slot;
>> +     unsigned int spkfb_slot;
>> +     bool interleave_mode;
>> +     unsigned int ch_size;
>> +     unsigned int iface;
>> +     bool tdm_mode;
>> +};
>
>About this max98373->codec.
>This user is only max98373_set_clock(), and it is called from
>max98373_dai_hw_params().
>You are getting *codec from dai->codec in this function, and max98373 is
>came from it.
>This means, we can remove max98373->codec ?

Thanks for your feedback.
I will remove max98373->codec and change related things.

>
>About max98373->regmap.
>You are using devm_regmap_init_i2c(), and keeping it on max98373.
>Can you check snd_soc_component_add() which is called from
>snd_soc_add_component().
>It will set component->regmap if you called devm_regmap_init_i2c().
>I think you can use snd_soc_component_read/write instead of
>regmap_read/write.
>Then, we can remove max98373->regmap too ?
>Ahh, you want to check Revision ID.
>then, snd_soc_component_init_regmap() can help you ?

I'm sorry but I don't fully understand the benefit of this.
Keeping regmap information in private driver data is very common and I can =
see many ASoC drivers are using it.
I was able to see only a few driver use ' snd_soc_component_read'.
I would like to keep regmap_read/write if it is still acceptable.

>
>Best regards
>---
>Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
