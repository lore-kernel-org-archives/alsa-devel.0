From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 1/2] ASoC: core: allow DAI PCM controls
 bound to PCM device
Date: Mon, 28 Nov 2016 16:18:39 +0100
Message-ID: <b670f0ca-8763-846b-90ca-b7e0dcfe4070@st.com>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
 <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
 <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 37AE7266D6B
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:18:44 +0100 (CET)
In-Reply-To: <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 11/28/2016 02:18 PM, Takashi Sakamoto wrote:
> On Nov 28 2016 18:33, Arnaud Pouliquen wrote:
>> In case of several instances of the same PCM control (e.g IEC controls).
>> Application should be able to address the control using the
>> device field number, according to the PCM character device.
>> This patch allows to link DAI PCM controls to the PCM device.
>> During DAI_link probe, PCM controls are added after device field is forced
>> to the PCM device number.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  include/sound/soc-dai.h |  4 ++++
>>  sound/soc/soc-core.c    | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 964b7de..93624c9 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -247,6 +247,10 @@ struct snd_soc_dai_driver {
>>  	/* probe ordering - for components with runtime dependencies */
>>  	int probe_order;
>>  	int remove_order;
>> +
>> +	/* Optional PCM controls to bind to PCM device on DAIs link*/
>> +	const struct snd_kcontrol_new *pcm_controls;
>> +	int num_pcm_controls;
>>  };
>>
>>  /*
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 4afa8db..ace83c9 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1552,6 +1552,25 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
>>  	return 0;
>>  }
>>
>> +static int soc_link_dai_pcm_controls(struct snd_soc_dai **dais, int num_dais,
>> +				     struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_kcontrol_new kctl;
>> +	int i, j, err;
>> +
>> +	for (i = 0; i < num_dais; ++i) {
>> +		for (j = 0; j < dais[i]->driver->num_pcm_controls; j++) {
>> +			kctl = dais[i]->driver->pcm_controls[j];
>> +			if (!rtd->dai_link->no_pcm)
>> +				kctl.device = rtd->pcm->device;
> 
> For the above codes, please request some comment to the other developers 
> working for ALSA SoC part. I'm not so experienced developer for this 
> part, sorry.
I think something is missing here, to return an error if following
condition is not respected: iface == SNDRV_CTL_ELEM_IFACE_PCM
I'm going to add a test.
> 
>> +			if (snd_soc_add_dai_controls(dais[i], &kctl, 1))
>> +				return err;
> 
> Return value from snd_soc_add_dai_controls() should be assigned to the 
> 'err' variable, I think.

Oops, stupid mistake... thanks! i will correct it in my next version
> 
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int soc_link_dai_widgets(struct snd_soc_card *card,
>>  				struct snd_soc_dai_link *dai_link,
>>  				struct snd_soc_pcm_runtime *rtd)
>> @@ -1663,6 +1682,15 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>>  				       dai_link->stream_name, ret);
>>  				return ret;
>>  			}
>> +
>> +			/* Bind DAIs pcm controls to the PCM device */
>> +			ret = soc_link_dai_pcm_controls(&cpu_dai, 1, rtd);
>> +			if (ret < 0)
>> +				return ret;
>> +			ret = soc_link_dai_pcm_controls(rtd->codec_dais,
>> +							rtd->num_codecs, rtd);
>> +			if (ret < 0)
>> +				return ret;
>>  		} else {
>>  			INIT_DELAYED_WORK(&rtd->delayed_work,
>>  						codec2codec_close_delayed_work);
> 
> In the other part of this subsystem, the first parameter of helper 
> functions typically represents a 'subject'. In this context, the subject 
> is PCM runtime specialized for ALSA SoC part, which get some new control 
> element sets for the PCM runtime. Therefore, it's better to move the 
> 'rtd' parameter to the first argument. (This is not so strong demand, 
> and somewhat depends on developers' taste. Furthermore, I have no 
> self-confidence to tell my intension to you correctly in English...)

I understand your point. Nevertheless, i would not see the PCM runtime
as subject, but the DAI. In this way, I was inspired by the
soc_link_dai_widgets helper that is also in the subsytem...
if rtd is the subject, i think soc_link_dai_pcm_controls should
also be renamed snd_soc_runtime_link_dai_ctls (or something like that)

But i'm not expert in ASoC semantic, so based on my answer, please
confirm me you point of view, i will integrate it in my V4 with other fixes.

Regards

Arnaud
