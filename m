From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 2/4] Alsa: control: increment index field for
 duplicated control.
Date: Wed, 9 Nov 2016 11:32:03 +0100
Message-ID: <ab7ae47f-11cb-3f09-6a91-807d028dba28@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <1478592675-23092-3-git-send-email-arnaud.pouliquen@st.com>
 <01cac646-0abb-caa7-fe59-dee1f5d4a755@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id F3419266BF5
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 11:32:07 +0100 (CET)
In-Reply-To: <01cac646-0abb-caa7-fe59-dee1f5d4a755@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On 11/09/2016 05:04 AM, Takashi Sakamoto wrote:
> Hi,
> 
> On Nov 8 2016 17:11, Arnaud Pouliquen wrote:
>> Instead of returning an error when a control is already present, the
>> index field is incremented and a warning message is printed.
>> This allows drivers to instanciate same control without
>> device and sub device number management ( MIXER type controls).
>>
>> Change-Id: Ifcc60dca9d1cf4c3a424bb9653296678aa7953cb
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  sound/core/control.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/core/control.c b/sound/core/control.c
>> index fb096cb..014e3f4 100644
>> --- a/sound/core/control.c
>> +++ b/sound/core/control.c
>> @@ -365,6 +365,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
>>  	struct snd_ctl_elem_id id;
>>  	unsigned int idx;
>>  	unsigned int count;
>> +	struct snd_kcontrol *elem_set;
>>  	int err = -EINVAL;
>>
>>  	if (! kcontrol)
>> @@ -376,17 +377,24 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
>>  		goto error;
>>
>>  	down_write(&card->controls_rwsem);
>> -	if (snd_ctl_find_id(card, &id)) {
>> -		up_write(&card->controls_rwsem);
>> -		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
>> -					id.iface,
>> -					id.device,
>> -					id.subdevice,
>> -					id.name,
>> -					id.index);
>> -		err = -EBUSY;
>> -		goto error;
>> +	while (elem_set = snd_ctl_find_id(card, &id)) {
>> +		id.index++;
>> +		if (id.index > UINT_MAX - kcontrol->count) {
>> +			up_write(&card->controls_rwsem);
>> +			dev_err(card->dev, "no more free index for control %i:%i:%i:%s\n",
>> +				id.iface, id.device, id.subdevice, id.name);
>> +			err = -ENOSPC;
>> +			goto error;
>> +		}
>> +	}
>> +	if (kcontrol->id.index != id.index) {
>> +		dev_warn(card->dev, "control %i:%i:%i:%s:%i is already present\n",
>> +			 id.iface, id.device, id.subdevice, id.name, id.index);
>> +		dev_warn(card->dev, "control index updated from %i to %i\n",
>> +			 kcontrol->id.index, id.index);
>> +		kcontrol->id.index = id.index;
>>  	}
>> +
>>  	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
>>  		up_write(&card->controls_rwsem);
>>  		err = -ENOMEM;
> 
> As Iwai-san explained below, this integration is a bit 
> over-specification in control core, because your issue is specific in 
> ALSA SoC part.
> 
> 
> On Nov 8 2016 23:30, Takashi Iwai wrote:
>  > Right, this behavior must be optional.  For the normal drivers, the
>  > duplicated controls *are* errors, and we catch it instead.  For
>  > drivers that are aware of confliction and want the automatic
>  > workaround (e.g. HD-audio driver does it already), this kind of code
>  > would be useful to be in the common place.
> (http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/114430.html)
> 
> For drivers outside of ALSA SoC part, developers can and should program 
> control element sets with unique identification information, because 
> design of sound card is fixed at development time. Therefore, these 
> codes should be in ALSA SoC core, as I introduced once.
> 
> When we have the same requirement for drivers outside of ALSA SoC part, 
> then we're going to move these codes from ALSA SoC core to ALSA control 
> core, I think.

I have generalized this in control.c, precisely because, as you pointed,
HDA-audio as same requirement. In other words, this could also seem as
an helper for the control indexation.
Now no problem to limit it to ASoC as you propose (need to implement it
in snd_soc_cnew to take into account prefix).

Now regarding the discussion and the set of patches in my RFC:
In my environment, this patch is mandatory to be able to address 'IEC958
Playback Default' control using iecset application.
if patch in iecset is accepted, it is no more mandatory.
(http://www.spinics.net/lists/alsa-devel/msg56480.html)

So the right way to do it, is to propose the iecset patch in a first step.
Then if it is rejected or if you estimate that patch makes sense anyway
for other "generic" controls i will rework it and propose it.

Thanks and Regards
Arnaud
