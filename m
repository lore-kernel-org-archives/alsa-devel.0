From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Wed, 02 Jul 2014 14:53:50 +0200
Message-ID: <53B400DE.3040205@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <20140701164134.GH2296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D6E262618
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 14:53:53 +0200 (CEST)
Received: by mail-wg0-f49.google.com with SMTP id y10so11107379wgg.8
 for <alsa-devel@alsa-project.org>; Wed, 02 Jul 2014 05:53:52 -0700 (PDT)
In-Reply-To: <20140701164134.GH2296@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 01/07/2014 18:41, Vinod Koul wrote:
> On Tue, Jul 01, 2014 at 09:47:59AM +0200, Benoit Cousson wrote:
>> Add multicodec support in soc-compress.c
>>
>> @@ -294,13 +299,19 @@ static int soc_compr_trigger(struct snd_compr_stre=
am *cstream, int cmd)
>>   			goto out;
>>   	}
>>
>> -	switch (cmd) {
>> -	case SNDRV_PCM_TRIGGER_START:
>> -		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
>> -		break;
>> -	case SNDRV_PCM_TRIGGER_STOP:
>> -		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
>> -		break;
>> +	for (i =3D 0; i < rtd->num_codecs; i++) {
>> +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +
>> +		switch (cmd) {
>> +		case SNDRV_PCM_TRIGGER_START:
>> +			snd_soc_dai_digital_mute(codec_dai, 0,
>> +						 cstream->direction);
>> +			break;
>> +		case SNDRV_PCM_TRIGGER_STOP:
>> +			snd_soc_dai_digital_mute(codec_dai, 1,
>> +						 cstream->direction);
> Wouldnt it make sense to fix snd_soc_dai_digital_mute() for multi-codecs.=
 Did
> you do same thing for pcm?

What do you mean by fix for multi-codecs?

>
>> +			break;
>> +		}
>>   	}
>>
>>   out:
>> @@ -622,23 +633,33 @@ int soc_new_compress(struct snd_soc_pcm_runtime *r=
td, int num)
>>   {
>>   	struct snd_soc_codec *codec =3D rtd->codec;
>>   	struct snd_soc_platform *platform =3D rtd->platform;
>> -	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>>   	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>>   	struct snd_compr *compr;
>>   	struct snd_pcm *be_pcm;
>>   	char new_name[64];
>> -	int ret =3D 0, direction =3D 0;
>> -
>> -	/* check client and interface hw capabilities */
>> -	snprintf(new_name, sizeof(new_name), "%s %s-%d",
>> -			rtd->dai_link->stream_name, codec_dai->name, num);
>> -
>> -	if (codec_dai->driver->playback.channels_min)
>> -		direction =3D SND_COMPRESS_PLAYBACK;
>> -	else if (codec_dai->driver->capture.channels_min)
>> -		direction =3D SND_COMPRESS_CAPTURE;
>> -	else
>> -		return -EINVAL;
>> +	int i, ret =3D 0, direction =3D -1;
>> +
>> +	for (i =3D 0; i < rtd->num_codecs; i++) {
>> +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +		/* check client and interface hw capabilities */
>> +		snprintf(new_name, sizeof(new_name), "%s %s-%d",
>> +			 rtd->dai_link->stream_name, codec_dai->name, num);
>> +
>> +		if (direction < 0) {
>> +			if (codec_dai->driver->playback.channels_min)
>> +				direction =3D SND_COMPRESS_PLAYBACK;
>> +			else if (codec_dai->driver->capture.channels_min)
>> +				direction =3D SND_COMPRESS_CAPTURE;
> direction wont change with multiple codecs, so this loop makes no sense h=
ere.
> For simplcity perhaps we can use cpu_dai?
>> +			else
>> +				return -EINVAL;
>> +		} else {
> when will this get executed? You have initialized direction to -1 and if =
case is
> always true. I think compiler will simply remove the below sinppet.

direction is set to -1, then the first iteration will set it to the =

direction of the first codec_dai. The other iteration are just checking =

that there are all in the same direction and will fail otherwise.

>> +			if ((codec_dai->driver->playback.channels_min &&
>> +					direction !=3D SND_COMPRESS_PLAYBACK) ||
>> +			    (codec_dai->driver->capture.channels_min &&
>> +					direction !=3D SND_COMPRESS_CAPTURE))
> and what exactly are we trying to check here?

That every codec_dai are in the same direction.

If you think this is pointless since every DAI are always in the same =

direction, we can just remove it.

>> +				return -EINVAL;
>> +		}
>> +	}
>>
>>   	compr =3D kzalloc(sizeof(*compr), GFP_KERNEL);
>>   	if (compr =3D=3D NULL) {
>> @@ -692,8 +713,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rt=
d, int num)
>>   	rtd->compr =3D compr;
>>   	compr->private_data =3D rtd;
>>
>> -	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->n=
ame,
>> -		cpu_dai->name);
>> +	for (i =3D 0; i < rtd->num_codecs; i++) {
>> +		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +		printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
>> +		       codec_dai->name, cpu_dai->name);
> wrong again. You are not creating multiple links with multi-codec. Link i=
s still
> single.

Yeah, I know, the idea was to print that we have multiple codec. I'll =

use the same "multicodec" info like we did for PCM.

Thanks for the feedback,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
