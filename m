From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC v2 1/3] ASoC: core: allow DAI PCM controls
 bound to PCM device
Date: Thu, 24 Nov 2016 07:14:52 +0200
Message-ID: <1f53b56a-719c-4711-59eb-ba11a42f3773@sakamocchi.jp>
References: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
 <1479811996-2238-2-git-send-email-arnaud.pouliquen@st.com>
 <20161124045513.GS2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5F06F26706A
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 06:15:04 +0100 (CET)
In-Reply-To: <20161124045513.GS2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Vinod,

On Nov 24 2016 06:55, Vinod Koul wrote:
>> In case of several instances of the same PCM control (e.g IEC controls).
> 
> Why are we calling it PCM controls? They are just alsa kcontrols, maybe
> used for doing some PCM configuration but then they are just controls.

He (Arnaud) requires some control element sets which have relationships
to corresponding ALSA PCM character devices.

The control element set of 'IEC958' type is an practical example. When a
sound card has PCM components for configurable S/PDIF interface (both of
IEC 60958-3 and -4 are available), DAI drivers should produce control
element sets for user space application to configure them. His idea is
for this issue.

In this patchset, to make relationship between a control element set and
a PCM device, 'device' field of identification information of control
element set is used. This requires changes of ALSA SoC core because the
core decide the device number by itself and it's not transparent for
interface/codec drivers.

> The same problem (same control names IIUC) existis on codec and SoC's, now
> that both have DSP, we can have DSP "Volume control"...
> 
> Would this solve that as well..?

No. It's not the aim of this patchset and out of its scope.

However, in fact, we should seek good solution for the issue of
'conflict of identification information of control element set added by
ALSA SoC part automatically'.

>> Application should be able to address the control using the
>> device field number, according to the PCM character device.
>> This patch allows to link DAI PCM controls to the PCM device.
> 
> why is that part required..? Is the problem being solved to address a
> control uniquely or something else?
>
>> During DAI_link probe, PCM controls are added after device field is forced
>> to the PCM device number.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  include/sound/soc-dai.h |  4 ++++
>>  sound/soc/soc-core.c    | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 200e1f0..3ff1a86 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -273,6 +273,10 @@ struct snd_soc_dai_driver {
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
>> index aaab26a..a494287 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1598,6 +1598,25 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
>>  	return 0;
>>  }
>>  
>> +static int soc_link_dai_pcm_controls(struct snd_soc_card *card,
>> +				     struct snd_soc_dai *dai,
>> +				     struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_kcontrol_new kctl;
>> +	struct snd_soc_dai_driver *drv = dai->driver;
>> +	int i, err;
>> +
>> +	for (i = 0; i < drv->num_pcm_controls; i++) {
>> +		kctl = drv->pcm_controls[i];
>> +		if (!rtd->dai_link->no_pcm)
>> +			kctl.device = rtd->pcm->device;
>> +		if (snd_soc_add_dai_controls(dai, &kctl, 1))
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int soc_link_dai_widgets(struct snd_soc_card *card,
>>  				struct snd_soc_dai_link *dai_link,
>>  				struct snd_soc_pcm_runtime *rtd)
>> @@ -1709,6 +1728,24 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>>  				       dai_link->stream_name, ret);
>>  				return ret;
>>  			}
>> +
>> +			/* Bind DAIs pcm controls to the PCM device */
>> +			if (cpu_dai->driver->pcm_controls) {
>> +				ret = soc_link_dai_pcm_controls(card, cpu_dai,
>> +								rtd);
>> +				if (ret < 0)
>> +					return ret;
>> +			}
>> +			for (i = 0; i < rtd->num_codecs; i++) {
>> +				struct snd_soc_dai *dai = rtd->codec_dais[i];
>> +
>> +				if (dai->driver->pcm_controls)
>> +					ret = soc_link_dai_pcm_controls(card,
>> +									dai,
>> +									rtd);
>> +				if (ret < 0)
>> +					return ret;
>> +			}
>>  		} else {
>>  			INIT_DELAYED_WORK(&rtd->delayed_work,
>>  						codec2codec_close_delayed_work);
>> -- 
>> 1.9.1

Regards

Takashi Sakamoto @UTC+2
