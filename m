From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH 1/9] ASoC: max98927: Added TDM support
Date: Mon, 28 Aug 2017 23:34:41 +0000
Message-ID: <BY2PR11MB083775428D2A7EBE6D9D0725E79E0@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170827140238.bqav6pkpxd2yogch@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170827140238.bqav6pkpxd2yogch@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>Subject: Re: [PATCH 1/9] ASoC: max98927: Added TDM support
>
>On Fri, Aug 25, 2017 at 05:41:02PM -0700, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <mailto:ryans.lee@maximintegrated.com>
>
>This says it's adding support for TDM mode but...
>
>> +	case SND_SOC_DAIFMT_DSP_A:
>> +		format =3D MAX98927_PCM_FORMAT_TDM_MODE1;
>> +		break;
>> +	case SND_SOC_DAIFMT_DSP_B:
>> +		format =3D MAX98927_PCM_FORMAT_TDM_MODE0;
>> +		break;
>>  	case SND_SOC_DAIFMT_PDM:
>> -		max98927->iface |=3D SND_SOC_DAIFMT_PDM;
>> +		use_pdm =3D true;
>>  		break;
>
>...it looks like it's adding support for two new DSP modes and generally m=
aking a
>bunch of other changes.  This probably needs splitting up, or at least a b=
it more
>of a changelog.

I wanted to split this patch but changes were all about DSP_A and DSP_B for=
mat support.
I added more description about this patch and send patch series again.
