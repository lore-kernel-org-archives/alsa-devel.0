From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ASoC: soc-core: call
 snd_soc_remove_card() when component del
Date: Mon, 09 Feb 2015 12:26:02 +0100
Message-ID: <54D8994A.5090906@metafoo.de>
References: <87siefv54e.wl%kuninori.morimoto.gx@renesas.com>	<87mw4nv524.wl%kuninori.morimoto.gx@renesas.com>
 <s5hzj8ntl5z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-212.synserver.de (smtp-out-216.synserver.de
 [212.40.185.216])
 by alsa0.perex.cz (Postfix) with ESMTP id 969822605A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 12:26:21 +0100 (CET)
In-Reply-To: <s5hzj8ntl5z.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 02/09/2015 11:48 AM, Takashi Iwai wrote:
> At Mon, 9 Feb 2015 08:52:49 +0000,
> Kuninori Morimoto wrote:
>>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> ASoC devices are organized as CPU-CARD-CODEC. Then, CPU/CODEC
>> are based on component structure. Now, each CARD device knows
>> connected component. But CARD doesn't notice if connected component
>> was removed when user called rmmod or unbind in current implementation.
>> Thus, CARD which lost some components still exist in system.
>> And then, ALSA sound card will have some problem if user used this CARD
>> in such timing. This patch temporarily removes CARD from system
>> if connected component was removed, and re-add it if some component
>> was added.
>>
>> Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
>> Reported-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
>> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   include/sound/soc.h  |    1 +
>>   sound/soc/soc-core.c |   26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index b4fca9a..a90eff4 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -1083,6 +1083,7 @@ struct snd_soc_card {
>>   	struct list_head paths;
>>   	struct list_head dapm_list;
>>   	struct list_head dapm_dirty;
>> +	struct list_head unbinded_list;
>>
>>   	/* Generic DAPM context for the card */
>>   	struct snd_soc_dapm_context dapm;
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index b7ab676..f8d5498 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -56,6 +56,7 @@ static DEFINE_MUTEX(client_mutex);
>>   static LIST_HEAD(platform_list);
>>   static LIST_HEAD(codec_list);
>>   static LIST_HEAD(component_list);
>> +static LIST_HEAD(unbinded_card_list);
>>
>>   /*
>>    * This is a timeout to do a DAPM powerdown after a stream is closed().
>> @@ -2406,6 +2407,10 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
>>   		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
>>   	}
>>
>> +	mutex_lock(&client_mutex);
>> +	list_del(&card->unbinded_list);
>> +	mutex_unlock(&client_mutex);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
>> @@ -2669,6 +2674,9 @@ EXPORT_SYMBOL_GPL(snd_soc_component_exit_regmap);
>>
>>   static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
>>   {
>> +	struct snd_soc_card *card, *_card;
>> +	int ret;
>> +
>>   	if (!component->write && !component->read) {
>>   		if (!component->regmap)
>>   			component->regmap = dev_get_regmap(component->dev, NULL);
>> @@ -2677,6 +2685,16 @@ static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
>>   	}
>>
>>   	list_add(&component->list, &component_list);
>> +
>> +	/* re-add temporarily removed card if exist */
>> +	list_for_each_entry_safe(card, _card, &unbinded_card_list,
>> +				 unbinded_list) {
>> +		ret = snd_soc_instantiate_card(card);
>> +		if (ret < 0)
>> +			continue;
>> +
>> +		list_del(&card->unbinded_list);
>> +	}
>
> [Cc'ed Lars-Peter]
>
> This would instantiate a card even if it's irrelevant with the given
> component?  If so, it looks fragile, and possibly racy, when there are
> multiple cards.

That shouldn't be a problem. snd_soc_instantiate_card() does the proper 
locking and will return an error if not all components are ready yet.

I think the main issue with this path is that snd_soc_unregister_card() will 
crash if the card is not on the unbinded_card_list, which in most cases it 
won't be.

The other issue is that it introduces subtly issues with the suspend and 
resume order. Suspend and resume are called in the order in which the probe 
functions of devices are called (and succeed). By returning -EPROBE_DEFER in 
the card driver we make sure that the card's probe function is always called 
after the probe functions of all the components of the card have run. This 
again causes the card's suspend function to be called before any suspend 
function of any of it's components. Now with this patch it is possible again 
for a component's probe function to be called after the card's probe 
function which changes the suspend and resume order and might break things.

This patch essentially is a partial revert of commit b19e6e7b763 ("ASoC: 
core: Use driver core probe deferral") where the card list was replaced with 
the -EPROBE_DEFER mechanism.

So while this patch fixes the nasty crash it introduces some other subtle 
issue. Maybe we should also add a big WARN() when a component of a card is 
removed while still in use until the other issues are also fixed.

Ideally the correct fix would somehow make sure that the card itself is 
unbound and put back onto the probe_defer list.

- Lars
