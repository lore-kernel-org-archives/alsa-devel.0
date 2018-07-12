From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: core: add support to card re-bind/unbind using
 component framework
Date: Thu, 12 Jul 2018 13:02:54 +0100
Message-ID: <c4eae2f4-8094-bf09-abed-bfd7a0428f34@linaro.org>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <20180712105910.GU3219@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712105910.GU3219@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for taking look at this!

On 12/07/18 11:59, Vinod wrote:
> On 11-07-18, 09:43, Srinivas Kandagatla wrote:
>> This patch aims at add achieving dynamic behaviour of audio card when
>> the dependent components disappear and reappear.
>>
>> With this patch the card is removed if any of the dependent component
>> is removed and card is added back if the dependent component comes back.
>> All this is done using component framework and matching based on
>> component name.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Looks fine mostly, some nitpicks below:
> 
>> ---
>>
>> During discussion regarding card re-binding when components unregister
>> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
>> that component framework can be added into core to provide this feature.
>>
>> With this new changes the card will re-bind once the dependent component
>> re-registers after unregistering. This works based on the match done
>> from component name using component framework.
>>
>> I have tested this patch with qdsp start-stop usecase for more than 10000
>> times in loop on Qcom platforms.
>>
>> I will send qdsp side cleanup patches once I get some feedback on this patch.
>>
>>
>>   include/sound/soc.h  |  5 ++++
>>   sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>   2 files changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 870ba6b64817..b94149d29c0d 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/workqueue.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> +#include <linux/component.h>
>>   #include <linux/regmap.h>
>>   #include <linux/log2.h>
>>   #include <sound/core.h>
>> @@ -1088,6 +1089,10 @@ struct snd_soc_card {
>>   
>>   	struct work_struct deferred_resume_work;
>>   
>> +	/* component framework related */
>> +	bool components_added;
>> +	struct component_match *match;
>> +
>>   	/* lists of probed devices belonging to this card */
>>   	struct list_head component_dev_list;
>>   
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 6d33634b934b..377ed8e67686 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
>>   
>>   #endif
>>   
>> +static int snd_soc_card_comp_compare(struct device *dev, void *data)
> 
> Why not make last arg as name and avoid void *
> 

I can rename argument "data" to "name", but I can not change the 
prototype of the compare callback expected by component framework.

>> +{
>> +	struct snd_soc_component *component = NULL;
>> +	struct snd_soc_component *t;
> 
> why do you need two variables for this

We need two because one is iterator and other is find.

if we use just one we will endup with valid iterator item which may not 
have matched dev.

Or I can re-organize/simplify the code like this:

static int snd_soc_card_comp_compare(struct device *dev, void *name)
{
         struct snd_soc_component *t;

         lockdep_assert_held(&client_mutex);
         list_for_each_entry(t, &component_list, list) {
                 if (dev == t->dev) {
                         if (!strcmp(t->name, name))
                                 return 1;
                 }
         }

         return 0;
}

>> +
>> +	lockdep_assert_held(&client_mutex);
>> +	list_for_each_entry(t, &component_list, list) {
>> +		if (dev == t->dev) {
>> +			component = t;
> 
> you can skip this line and use t in below code.
> 
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (component && !strcmp(component->name, data))
> 


> strncmp?

AFAIU, strcmp should be safe here as component->name is 
generated/sanitized by core and would be of max len of NAME_SIZE.
core uses strcmp in may places. Any particular reason you want me to 
move to strncmp?
> 
