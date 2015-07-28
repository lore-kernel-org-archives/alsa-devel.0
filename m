From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: fix module unload/reload
 failed issue by reset kcontrol's widget list
Date: Tue, 28 Jul 2015 22:40:57 +0200
Message-ID: <55B7E8D9.8050208@metafoo.de>
References: <1438074219-26408-1-git-send-email-yang.jie@intel.com>
 <s5hpp3cveeq.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90557B055@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B0126128B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 22:40:59 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90557B055@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 07/28/2015 04:34 PM, Jie, Yang wrote:
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Tuesday, July 28, 2015 5:07 PM
>> To: Jie, Yang
>> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
>> Subject: Re: [PATCH] ASoC: dapm: fix module unload/reload failed issue by
>> reset kcontrol's widget list
>>
>> On Tue, 28 Jul 2015 11:03:39 +0200,
>> Jie Yang wrote:
>>>
>>> We need reset the related kcontrol's widget list during the freeing of
>>> a widget, otherwise, the widget list may be outdated and reference to
>>> it may introduce errors(they usually occurs during driver modules
>>> unloading/reloading).
>>>
>>> Here adding a func dapm_update_kcontrols_of_freeing_widget and call it
>>> at dapm_update_kcontrols_of_freeing_widget, to fix those issues.
>>>
>>> Signed-off-by: Jie Yang <yang.jie@intel.com>
>>> ---
>>>   sound/soc/soc-dapm.c | 31 +++++++++++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c index
>>> aa327c9..1ad8144 100644
>>> --- a/sound/soc/soc-dapm.c
>>> +++ b/sound/soc/soc-dapm.c
>>> @@ -2305,6 +2305,35 @@ static void dapm_free_path(struct
>> snd_soc_dapm_path *path)
>>>   	kfree(path);
>>>   }
>>>
>>> +/* update all dapm kcontrols that related to a widget which being
>>> +freed*/ static void dapm_update_kcontrols_of_freeing_widget(struct
>>> +snd_soc_dapm_widget * w) {
>>> +	struct dapm_kcontrol_data *data = NULL;
>>> +	int i, j, n;
>>> +
>>> +	if (w && w->kcontrols) {
>>> +		for (i = 0; i < w->num_kcontrols; i++) {
>>> +			if (w->kcontrols[i] == NULL)
>>> +				continue;
>>> +			data = snd_kcontrol_chip(w->kcontrols[i]);
>>> +			if (data == NULL)
>>> +				continue;
>>> +			for (j = 0, n = 0; j < data->wlist->num_widgets; j++) {
>>> +				if (data->wlist->widgets[j] == w) {
>>> +					data->wlist->widgets[j] = NULL;
>>> +					n++;
>>> +				}
>>> +			}
>>> +
>>> +			if (n) {
>>> +				data->wlist->num_widgets -= n;
>>
>> This looks buggy.  You didn't rearrange widgets[] but just put a hole, yet
>> decreasing the number.
>
> You are right, but since krealloc() cannot shrink the allocated size, maybe we should
> free those related kcontrols here?
>
>>
>> BTW, how does the reference occur while unloading?  Or better to say:
>> isn't it the module refcount adjusted while accessing the resources?
>
>
> soc_cleanup_card_resources
> 	snd_soc_dapm_free
> 		dapm_free_widgets
> 	snd_card_free
> 		//removing kcontrols, calling private dapm_kcontrol_free()
> 			kfree(data->widget->name);//the widget here may be
> 					//already freed! So the reference here
> 					//may cause error.

Hi,

that free was wrong no matter what, since the widget itself frees the name. 
So even if widget is valid this would result in a double free.

The issue was fixed in this commit: 
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit?h=for-next&id=e18077b6e5dfe26e9fbbdc1fd1085a1701c24bea

- Lars
