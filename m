From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 03 Jul 2014 13:09:28 +0200
Message-ID: <53B539E8.1000301@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com> <53B400DE.3040205@baylibre.com>
 <20140703064147.GK2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id EB8C92654BC
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 13:09:32 +0200 (CEST)
Received: by mail-wg0-f44.google.com with SMTP id k14so50128wgh.15
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 04:09:32 -0700 (PDT)
In-Reply-To: <20140703064147.GK2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lars@metafoo.de
Cc: misael.lopez@ti.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/07/2014 08:41, Vinod Koul wrote:
> On Wed, Jul 02, 2014 at 02:53:50PM +0200, Benoit Cousson wrote:
>>>> @@ -622,23 +633,33 @@ int soc_new_compress(struct snd_soc_pcm_runtime =
*rtd, int num)
>>>>   {
>>>>   	struct snd_soc_codec *codec =3D rtd->codec;
>>>>   	struct snd_soc_platform *platform =3D rtd->platform;
>>>> -	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>>>>   	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>>>>   	struct snd_compr *compr;
>>>>   	struct snd_pcm *be_pcm;
>>>>   	char new_name[64];
>>>> -	int ret =3D 0, direction =3D 0;
>>>> -
>>>> -	/* check client and interface hw capabilities */
>>>> -	snprintf(new_name, sizeof(new_name), "%s %s-%d",
>>>> -			rtd->dai_link->stream_name, codec_dai->name, num);
>>>> -
>>>> -	if (codec_dai->driver->playback.channels_min)
>>>> -		direction =3D SND_COMPRESS_PLAYBACK;
>>>> -	else if (codec_dai->driver->capture.channels_min)
>>>> -		direction =3D SND_COMPRESS_CAPTURE;
>>>> -	else
>>>> -		return -EINVAL;
>>>> +	int i, ret =3D 0, direction =3D -1;
>>>> +
>>>> +	for (i =3D 0; i < rtd->num_codecs; i++) {
>>>> +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>>>> +		/* check client and interface hw capabilities */
>>>> +		snprintf(new_name, sizeof(new_name), "%s %s-%d",
>>>> +			 rtd->dai_link->stream_name, codec_dai->name, num);
>>>> +
>>>> +		if (direction < 0) {
>>>> +			if (codec_dai->driver->playback.channels_min)
>>>> +				direction =3D SND_COMPRESS_PLAYBACK;
>>>> +			else if (codec_dai->driver->capture.channels_min)
>>>> +				direction =3D SND_COMPRESS_CAPTURE;
>>> direction wont change with multiple codecs, so this loop makes no sense=
 here.
>>> For simplcity perhaps we can use cpu_dai?
>>>> +			else
>>>> +				return -EINVAL;
>>>> +		} else {
>>> when will this get executed? You have initialized direction to -1 and i=
f case is
>>> always true. I think compiler will simply remove the below sinppet.
>>
>> direction is set to -1, then the first iteration will set it to the
>> direction of the first codec_dai. The other iteration are just
>> checking that there are all in the same direction and will fail
>> otherwise.
>>
>>>> +			if ((codec_dai->driver->playback.channels_min &&
>>>> +					direction !=3D SND_COMPRESS_PLAYBACK) ||
>>>> +			    (codec_dai->driver->capture.channels_min &&
>>>> +					direction !=3D SND_COMPRESS_CAPTURE))
>>> and what exactly are we trying to check here?
>>
>> That every codec_dai are in the same direction.
>>
>> If you think this is pointless since every DAI are always in the
>> same direction, we can just remove it.
> I think that will simplify it. we certainly dont expect different directi=
on,
> right?

Lars, Mark
Any thought on that? Does that sound reasonable to you to use only the =

first codec_dai to figure out the direction?

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
