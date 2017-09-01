From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH 1/9] ASoC: max98927: Added support for DSP_A and DSP_B
 format
Date: Fri, 1 Sep 2017 21:37:48 +0000
Message-ID: <BY2PR11MB0837062B05627DCD5540CBB8E7920@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1503963061-14763-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170829190015.kpscn3uuwbvwlp6e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829190015.kpscn3uuwbvwlp6e@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Tuesday, August 29, 2017 12:00 PM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
>kuninori.morimoto.gx@renesas.com; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH 1/9] ASoC: max98927: Added support for DSP_A and DSP_B
>format
>
>On Mon, Aug 28, 2017 at 04:30:53PM -0700, Ryan Lee wrote:
>
>> +	if ((max98927->iface =3D=3D SND_SOC_DAIFMT_DSP_A) ||
>> +	    (max98927->iface =3D=3D SND_SOC_DAIFMT_DSP_B))
>> +		return 0;
>> +
>> +	/* BCLK configuration */
>
>Why do we not configure the BCLK in DSP modes?  That's unusual and seems
>likely to break some systems that rely on exact clocking.

I put this code to avoid overwrite BCLK value in TDM mode. BCLK is being co=
nfigured by ' max98927_dai_tdm_slot'.
Now I added one more variable to check TDM mode instead of checking DAI_FMT=
.

>
>Also if we're selecting on format a switch statement is generally better t=
o make
>any further special casing easier in future.

OK. Thanks. But I kept if statement on the modified version because it only=
 have two cases, tdm and non-tdm.
