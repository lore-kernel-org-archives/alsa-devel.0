From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 2/6] ALSA: pcm: add IEC958 channel status
	control helper
Date: Wed, 17 Feb 2016 09:37:44 +0100
Message-ID: <56C43158.6000409@st.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-3-git-send-email-arnaud.pouliquen@st.com>
 <56C383D0.4040201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1991265919
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 09:37:55 +0100 (CET)
In-Reply-To: <56C383D0.4040201@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org



On 02/16/2016 09:17 PM, Jyri Sarha wrote:
> On 01/22/16 19:48, Arnaud Pouliquen wrote:
>> Add IEC958 channel status helper that creates control to handle the
>> IEC60958 status bits.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>   include/sound/pcm_iec958.h | 16 ++++++++
>>   sound/core/pcm_iec958.c    | 99 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 115 insertions(+)
>>
>> diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
>> index 36f023a..7453ace 100644
>> --- a/include/sound/pcm_iec958.h
>> +++ b/include/sound/pcm_iec958.h
>> @@ -3,9 +3,25 @@
>>
>>   #include <linux/types.h>
>>
>> +/*
>> + * IEC 60958 controls parameters
>> + * Describes channel status and associated callback
>> + */
>> +struct snd_pcm_iec958_params {
>> +	/* call when control is updated by user */
>> +	int (*ctrl_set)(void *pdata, u8 *status, u8 len);
>> +
>> +	struct snd_aes_iec958 *iec;
>> +	void *pdata; /* user private data to retrieve context */
>> +	struct mutex *mutex; /* use to avoid race condition */
>> +};
>> +
>>   int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
>>   	size_t len);
>>
>>   int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
>>   					     u8 *cs, size_t len);
>> +
>> +int snd_pcm_create_iec958_ctl(struct snd_pcm *pcm,
>> +			      struct snd_pcm_iec958_params *params, int stream);
>>   #endif
>> diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
>> index c9f8b66..8dd0415 100644
>> --- a/sound/core/pcm_iec958.c
>> +++ b/sound/core/pcm_iec958.c
>> @@ -7,11 +7,87 @@
>>    */
>>   #include <linux/export.h>
>>   #include <linux/types.h>
>> +#include <linux/wait.h>
>>   #include <sound/asoundef.h>
>> +#include <sound/control.h>
>>   #include <sound/pcm.h>
>>   #include <sound/pcm_params.h>
>>   #include <sound/pcm_iec958.h>
>>
>> +int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
>> +			struct snd_ctl_elem_info *uinfo)
>> +{
>> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
>> +	uinfo->count = 1;
>> +	return 0;
>> +}
>> +
>> +static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
>> +			      struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
>> +
>> +	if (params->mutex)
>> +		mutex_unlock(params->mutex);
> 
> This here should be mutex_lock().
oops... Seems that i need to enable some debug configs in my environment...
My apologize for this copy/past and thanks for the test!
Anyway i need to perform further tests before deliver as patches instead
of rfc.
But i prefer to wait a decision on the HDMI codec before finalizing it.
