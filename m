From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] ASoC: hdmi-codec: add channel mapping
	control
Date: Mon, 12 Dec 2016 18:16:15 +0100
Message-ID: <60f5274f-abbd-4aff-c2e4-e17f4a496ea7@st.com>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
 <1481215067-19362-3-git-send-email-arnaud.pouliquen@st.com>
 <1cc79b45-d45c-35da-8e85-b349f0338866@sakamocchi.jp>
 <d9d775e9-b077-ae53-6b3f-6c4d6f40c0c3@st.com>
 <be85377b-5aae-5f3a-76da-8f2b851e5cfa@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A2294266499
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 18:16:21 +0100 (CET)
In-Reply-To: <be85377b-5aae-5f3a-76da-8f2b851e5cfa@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

>>>>  static const struct snd_kcontrol_new hdmi_controls[] = {
>>>>  	{
>>>>  		.access = SNDRV_CTL_ELEM_ACCESS_READ |
>>>> @@ -79,6 +400,17 @@ static const struct snd_kcontrol_new hdmi_controls[] = {
>>>>  		.info = hdmi_eld_ctl_info,
>>>>  		.get = hdmi_eld_ctl_get,
>>>>  	},
>>>> +	{
>>>> +		.access = SNDRV_CTL_ELEM_ACCESS_READ |
>>>> +			  SNDRV_CTL_ELEM_ACCESS_TLV_READ |
>>>> +			  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK |
>>>> +			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
>>>> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
>>>> +		.name = "Playback Channel Map",
>>>> +		.info = hdmi_codec_chmap_ctl_info,
>>>> +		.get = hdmi_codec_chmap_ctl_get,
>>>> +		.tlv.c = hdmi_codec_chmap_ctl_tlv,
>>>> +	},
>>>>  };
>>>
>>> If you can keep the same interface for applications as
>>> 'snd_pcm_add_chmap_ctls()' have, it's better to integrate the function
>>> to have different tables/callbacks depending on drivers.
>>>
>> I had a look before define it. Unfortunately i cannot use
>> snd_pcm_add_chmap_ctls. snd_pcm_add_chmap_ctls requests "snd_pcm"
>> structure as input param. ASoC codec not aware of it.
>> i could add an helper for ASoC, but hdmi-codec should be used for HDMI
>> drivers and i'm not sure that there is another need in ASoC.
> 
> For example, splitting the function to two parts; one gets the parameter 
> for pcm instance, another deal with adding control element sets. Symbols 
> of both functions are going to be exported and your code can reuse the 
> latter.
> 
> My motivation for this idea is to use the same code for control element 
> sets with the same name of 'Playback Channel Map'. In this case, usage 
> of the same code brings us an merit. We can produce the consist way for 
> applications to handle the control element sets, even if long term 
> development brings much code changes. It has an advantage to reduce 
> maintaining effort.
> 
> This is merely my initial idea. If it's impossible, your idea is preferable.
> 

I checked you proposal. I see 2 blocking points:
- ASoC core set the control private_data field to snd_soc_component so
it is not possible to reuse pcm_chmap_ctl_get/set/tlv that request
snd_pcm_chmap type for the private_data

- The control is a PCM control, so for multi instances it could have to
migrate to the pcm_controls field if following patch is accepted:
[PATCH v5 0/2] ALSA controls management using index/device/sub-devices
fields (http://www.spinics.net/lists/alsa-devel/msg57639.html)
in this case it must be created by the ASoC core and not the driver itself

Alternative could be to treat the control in soc-core:
In soc_link_dai_pcm_controls that is created in patch-set mentioned above.

I have to improve and test it(dirty code for concept...) but this would
be something like that :

static int soc_link_dai_pcm_controls(struct snd_soc_dai **dais, int
num_dais,
				     struct snd_soc_pcm_runtime *rtd)
{
	struct snd_kcontrol_new kctl;
	int i, j, ret;

	for (i = 0; i < num_dais; ++i) {
		for (j = 0; j < dais[i]->driver->num_pcm_controls; j++) {
			kctl = dais[i]->driver->pcm_controls[j];

+			/* TODO test also capture */
+			if(!strcmp(kctl->name, "Playback Channel Map") {
+				ret = snd_pcm_add_chmap_ctls(rtd->pcm,
+				  SNDRV_PCM_STREAM_PLAYBACK,
+				  /* Not very clean: chmap pointer is stored in private_value */
+				  (const struct snd_pcm_chmap_elem *) kctl.private_value,
+			   	  dai->driver->playback.max_channels,
+				  0, NULL);
+				continue;
+			}
			if (kctl.iface != SNDRV_CTL_ELEM_IFACE_PCM ||
			    rtd->dai_link->no_pcm) {
				dev_err(dais[i]->dev,
					"ASoC: Failed to bind %s control: %s\n",
					dais[i]->name, kctl.name);
				return -EINVAL;
			}
Regards
Arnaud
