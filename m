From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 1/2] ASoC: core: allow DAI PCM controls
 bound to PCM device
Date: Tue, 29 Nov 2016 22:03:15 +0900
Message-ID: <282511c9-0579-97f4-153d-4510eed33aaf@sakamocchi.jp>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
 <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
 <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
 <b670f0ca-8763-846b-90ca-b7e0dcfe4070@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BA0F22667CC
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 14:03:21 +0100 (CET)
In-Reply-To: <b670f0ca-8763-846b-90ca-b7e0dcfe4070@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 29 2016 00:18, Arnaud Pouliquen wrote:
>>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>>> index 4afa8db..ace83c9 100644
>>> --- a/sound/soc/soc-core.c
>>> +++ b/sound/soc/soc-core.c
>>> @@ -1552,6 +1552,25 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
>>>  	return 0;
>>>  }
>>>
>>> +static int soc_link_dai_pcm_controls(struct snd_soc_dai **dais, int num_dais,
>>> +				     struct snd_soc_pcm_runtime *rtd)
>>> +{
>>> +	struct snd_kcontrol_new kctl;
>>> +	int i, j, err;
>>> +
>>> +	for (i = 0; i < num_dais; ++i) {
>>> +		for (j = 0; j < dais[i]->driver->num_pcm_controls; j++) {
>>> +			kctl = dais[i]->driver->pcm_controls[j];
>>> +			if (!rtd->dai_link->no_pcm)
>>> +				kctl.device = rtd->pcm->device;
>>
>> For the above codes, please request some comment to the other developers
>> working for ALSA SoC part. I'm not so experienced developer for this
>> part, sorry.
> I think something is missing here, to return an error if following
> condition is not respected: iface == SNDRV_CTL_ELEM_IFACE_PCM
> I'm going to add a test.

When you have unclear points, it's better to ask them to the person who 
knows it. Furthermore, you attempt to change core codes of ALSA SoC 
part. Enough deliberation is preferable.

Liam Girdwood committed to the 'no_pcm' feature in below patch, and he 
is still active in this subsystem (I met him this month). You could 
request him to review.
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=01d7584cd2e5a93a2b959c9dddaa0d93ec205404

>>> +			if (snd_soc_add_dai_controls(dais[i], &kctl, 1))
>>> +				return err;
>>
>> Return value from snd_soc_add_dai_controls() should be assigned to the
>> 'err' variable, I think.
>
> Oops, stupid mistake... thanks! i will correct it in my next version

OK.

>> In the other part of this subsystem, the first parameter of helper
>> functions typically represents a 'subject'. In this context, the subject
>> is PCM runtime specialized for ALSA SoC part, which get some new control
>> element sets for the PCM runtime. Therefore, it's better to move the
>> 'rtd' parameter to the first argument. (This is not so strong demand,
>> and somewhat depends on developers' taste. Furthermore, I have no
>> self-confidence to tell my intension to you correctly in English...)
>
> I understand your point. Nevertheless, i would not see the PCM runtime
> as subject, but the DAI. In this way, I was inspired by the
> soc_link_dai_widgets helper that is also in the subsytem...
> if rtd is the subject, i think soc_link_dai_pcm_controls should
> also be renamed snd_soc_runtime_link_dai_ctls (or something like that)

Fair enough. I might had a confusion due to complexity of ALSA SoC part 
against ALSA control core, sorry.

> But i'm not expert in ASoC semantic, so based on my answer, please
> confirm me you point of view, i will integrate it in my V4 with other fixes.

Go a head.


Regards

Takashi Sakamoto
