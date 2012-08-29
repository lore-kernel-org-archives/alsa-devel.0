From: Raymond Celius <raymond@oblitech.com>
Subject: NRPACKS setting
Date: Wed, 29 Aug 2012 22:55:28 +0200
Message-ID: <B4C63CB1-2287-4B06-A8F7-8D7912816432@oblitech.com>
References: <mailman.530.1346249660.854.alsa-devel@alsa-project.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from submit01.uniweb.no (submit01.uniweb.no [91.207.158.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3F0265F91
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2012 22:55:31 +0200 (CEST)
In-Reply-To: <mailman.530.1346249660.854.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Is the NRPACKS setting equal to the number of packets per URB ?

Best regards,
Raymond

Den 29. aug.. 2012 kl. 16.14 skrev alsa-devel-request@alsa-project.org:

> Send Alsa-devel mailing list submissions to
> 	alsa-devel@alsa-project.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> or, via email, send a message with subject or body 'help' to
> 	alsa-devel-request@alsa-project.org
>
> You can reach the person managing the list at
> 	alsa-devel-owner@alsa-project.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Alsa-devel digest..."
>
>
> Today's Topics:
>
>   1. Re: [PATCH] ALSA: hda - Fix runtime PM accounting (Lin, Mengdong)
>   2. Re: Logitech USB headset not working in 3.6-rc3 (Takashi Iwai)
>   3. Re: Logitech USB headset not working in 3.6-rc3 (Daniel Mack)
>   4. Re: [PATCH] ALSA: hda - Fix runtime PM accounting (Takashi Iwai)
>   5. Re: Logitech USB headset not working in 3.6-rc3 (Takashi Iwai)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 29 Aug 2012 12:19:32 +0000
> From: "Lin, Mengdong" <mengdong.lin@intel.com>
> To: Takashi Iwai <tiwai@suse.de>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Fix runtime PM
> 	accounting
> Message-ID:
> 	<F46914AEC2663F4A9BB62374E5EEF8F81DAFDF@SHSMSX101.ccr.corp.intel.com>
> Content-Type: text/plain; charset="us-ascii"
>
>> Now I introduced codec->epss flag that is initialized once in
>> snd_hda_codec_new(), and let the codec driver overrides this flag.
>> One bonus is that you can avoid the unnecessary codec parameter  
>> read at
>> each power change.
>
> Yes, this is better. And the patch works well for me - [PATCH 1/2]  
> ALSA: hda - Avoid unnecessary parameter read for EPSS.
>
>> In anyway, there are a few issues:
>> - The refcounting gets broken after module unload.  It's because we
>>  leave the codec's pm_runtime usages after removal.
>
> Thanks for pointing out this! But I think the following codec can  
> introduce risk of race among multiple codecs to modify ' chip- 
> >power_count',
> because only one codec's power on/off is serialized.
> static void azx_power_notify(struct hda_bus *bus, struct hda_codec  
> *codec)
> {
> 	 ...
> 	if (codec->power_on) {
> 		pm_runtime_get_sync(&chip->pci->dev);
> 		chip->power_count++;
> 	} else {
> 		pm_runtime_put_sync(&chip->pci->dev);
> 		chip->power_count--;
> 	}
> }
>
> How about calling pm_runtime_put_noidle() when freeing a codec in D0?
> Maybe we can add a bus notify function like this:
> Static void azx_codec_free_notify(struct hda_codec *codec)
> {
> 	If(codec->power_on)
> 		pm_runtime_put_noidle(&codec->bus->pci->dev);
> }
> And snd_hda_codec_free() can trigger this notify.
>
>> - The D3-stop-clock check isn't done properly for the codecs  
>> providing
>>  own set_power_state ops.
>
> I cannot test the branch 'if (codec->patch_ops.set_power_state)' in  
> hda_set_power_state() for lack of such a codec.
> But the logic seems right and the other branch works well for me :-)
>
>> - Ditto for the repeated power-set sequence, the error check, etc.
> In hda_sync_power_state(),
> 	if ((state & 0xff) == power_state)   ... should be if ((state &  
> 0xf0)>> 4 == power_state), because PS-Act is bits 7:4
> 		break;
>
> And would you please explain why changing to D3 need not wait? One  
> of my codec does have a delay on change from D0 to D3.
>
> Thanks
> Mengdong
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 29 Aug 2012 15:29:03 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: Daniel Mack <zonque@gmail.com>
> Cc: Bruno Wolff III <bruno@wolff.to>, alsa-devel@alsa-project.org,
> 	linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>
> Subject: Re: [alsa-devel] Logitech USB headset not working in 3.6-rc3
> Message-ID: <s5hsjb56d40.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
>
> At Wed, 29 Aug 2012 13:26:25 +0200,
> Daniel Mack wrote:
>>
>> [1  <text/plain; ISO-8859-1 (7bit)>]
>> On 25.08.2012 14:17, Josh Boyer wrote:
>>> On Sat, Aug 25, 2012 at 02:13:58PM +0200, Daniel Mack wrote:
>>>> On 25.08.2012 14:07, Bruno Wolff III wrote:
>>>>> On Sat, Aug 25, 2012 at 14:02:51 +0200,
>>>>>   Daniel Mack <zonque@gmail.com> wrote:
>>>>>>
>>>>>> Can you revert commit e9ba389c5 ("ALSA: usb-audio: Fix
>>>>>> scheduling-while-atomic bug in PCM capture stream") and see if  
>>>>>> that
>>>>>
>>>>> I can try that, but it takes a long time to build a new kernel  
>>>>> on my
>>>>> old hardware.
>>>>>
>>>>>> helps? If not, can you summarize again which kernels still work  
>>>>>> for you
>>>>>> and which don't?
>>>>>
>>>>> The latest kernel that works is 3.6.0-0.rc2.git1.2.fc18. The  
>>>>> earliest that
>>>>> doesn't work is 3.6.0-0.rc2.git2.1.fc18.
>>>>>
>>>>
>>>> The report you sent doesn't look like it could be caused by  
>>>> e9ba389c5.
>>>> It fixes a kernel Ooops. But as it is the only relevant patch in  
>>>> that
>>>> area, it would be interesting if reverting it fixes anything.
>>>
>>> Yep, agreed.  If this revert kernel doesn't work, we're likely  
>>> down to a
>>> git bisect, Bruno.
>>>
>>>> Btw - thanks a lot for testing -rc kernels, much appreciated!
>>>
>>> Indeed!
>>
>> Could you please try this patch on top of Takashi's? Thanks again!
>>
>>
>> Daniel
>>
>> [2 0001-ALSA-snd-usb-Fix-URB-cancellation-at-stream-start.patch  
>> <text/x-patch (7bit)>]
>>> From 6617bb2463ae3fad21390b59cc2a71f96b9e9ca8 Mon Sep 17 00:00:00  
>>> 2001
>> From: Daniel Mack <zonque@gmail.com>
>> Date: Wed, 29 Aug 2012 13:17:05 +0200
>> Subject: [PATCH] ALSA: snd-usb: Fix URB cancellation at stream start
>>
>> Commit e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic bug  
>> in
>> PCM capture stream") fixed a scheduling-while-atomic bug that  
>> happened
>> when snd_usb_endpoint_start was called from the trigger callback,  
>> which
>> is an atmic context. However, the patch breaks the idea of the  
>> endpoints
>> reference counting, which is the reason why the driver has been
>> refactored lately.
>>
>> Revert that commit and let snd_usb_endpoint_start() take care of  
>> the URB
>> cancellation again. As this function is called from both atomic and
>> non-atomic context, add a flag to denote whether the function may  
>> sleep.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: stable@kernel.org [3.5+]
>> ---
>> sound/usb/endpoint.c | 10 ++++++++--
>> sound/usb/endpoint.h |  2 +-
>> sound/usb/pcm.c      | 13 +++++--------
>> 3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index c411812..678456c 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -799,7 +799,9 @@ int snd_usb_endpoint_set_params(struct  
>> snd_usb_endpoint *ep,
>> /**
>>  * snd_usb_endpoint_start: start an snd_usb_endpoint
>>  *
>> - * @ep: the endpoint to start
>> + * @ep:		the endpoint to start
>> + * @can_sleep:	flag indicating whether the operation is executed in
>> + * 		non-atomic context
>>  *
>>  * A call to this function will increment the use count of the  
>> endpoint.
>>  * In case it is not already running, the URBs for this endpoint  
>> will be
>> @@ -809,7 +811,7 @@ int snd_usb_endpoint_set_params(struct  
>> snd_usb_endpoint *ep,
>>  *
>>  * Returns an error if the URB submission failed, 0 in all other  
>> cases.
>>  */
>> -int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
>> +int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int  
>> can_sleep)
>> {
>> 	int err;
>> 	unsigned int i;
>> @@ -821,6 +823,10 @@ int snd_usb_endpoint_start(struct  
>> snd_usb_endpoint *ep)
>> 	if (++ep->use_count != 1)
>> 		return 0;
>>
>> +	/* just to be sure */
>> +	deactivate_urbs(ep, 0, can_sleep);
>> +	wait_clear_urbs(ep);
>
> It'd be safer to protect the call of wait_clear_urbs() when
> can_sleep=0.
>
>
> thanks,
>
> Takashi
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 29 Aug 2012 15:32:34 +0200
> From: Daniel Mack <zonque@gmail.com>
> To: Takashi Iwai <tiwai@suse.de>
> Cc: Bruno Wolff III <bruno@wolff.to>, alsa-devel@alsa-project.org,
> 	linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>
> Subject: Re: [alsa-devel] Logitech USB headset not working in 3.6-rc3
> Message-ID: <503E19F2.3080302@gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> On 29.08.2012 15:29, Takashi Iwai wrote:
>> At Wed, 29 Aug 2012 13:26:25 +0200,
>> Daniel Mack wrote:
>>>
>>> [1  <text/plain; ISO-8859-1 (7bit)>]
>>> On 25.08.2012 14:17, Josh Boyer wrote:
>>>> On Sat, Aug 25, 2012 at 02:13:58PM +0200, Daniel Mack wrote:
>>>>> On 25.08.2012 14:07, Bruno Wolff III wrote:
>>>>>> On Sat, Aug 25, 2012 at 14:02:51 +0200,
>>>>>>   Daniel Mack <zonque@gmail.com> wrote:
>>>>>>>
>>>>>>> Can you revert commit e9ba389c5 ("ALSA: usb-audio: Fix
>>>>>>> scheduling-while-atomic bug in PCM capture stream") and see if  
>>>>>>> that
>>>>>>
>>>>>> I can try that, but it takes a long time to build a new kernel  
>>>>>> on my
>>>>>> old hardware.
>>>>>>
>>>>>>> helps? If not, can you summarize again which kernels still  
>>>>>>> work for you
>>>>>>> and which don't?
>>>>>>
>>>>>> The latest kernel that works is 3.6.0-0.rc2.git1.2.fc18. The  
>>>>>> earliest that
>>>>>> doesn't work is 3.6.0-0.rc2.git2.1.fc18.
>>>>>>
>>>>>
>>>>> The report you sent doesn't look like it could be caused by  
>>>>> e9ba389c5.
>>>>> It fixes a kernel Ooops. But as it is the only relevant patch in  
>>>>> that
>>>>> area, it would be interesting if reverting it fixes anything.
>>>>
>>>> Yep, agreed.  If this revert kernel doesn't work, we're likely  
>>>> down to a
>>>> git bisect, Bruno.
>>>>
>>>>> Btw - thanks a lot for testing -rc kernels, much appreciated!
>>>>
>>>> Indeed!
>>>
>>> Could you please try this patch on top of Takashi's? Thanks again!
>>>
>>>
>>> Daniel
>>>
>>> [2 0001-ALSA-snd-usb-Fix-URB-cancellation-at-stream-start.patch  
>>> <text/x-patch (7bit)>]
>>>> From 6617bb2463ae3fad21390b59cc2a71f96b9e9ca8 Mon Sep 17 00:00:00  
>>>> 2001
>>> From: Daniel Mack <zonque@gmail.com>
>>> Date: Wed, 29 Aug 2012 13:17:05 +0200
>>> Subject: [PATCH] ALSA: snd-usb: Fix URB cancellation at stream start
>>>
>>> Commit e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic  
>>> bug in
>>> PCM capture stream") fixed a scheduling-while-atomic bug that  
>>> happened
>>> when snd_usb_endpoint_start was called from the trigger callback,  
>>> which
>>> is an atmic context. However, the patch breaks the idea of the  
>>> endpoints
>>> reference counting, which is the reason why the driver has been
>>> refactored lately.
>>>
>>> Revert that commit and let snd_usb_endpoint_start() take care of  
>>> the URB
>>> cancellation again. As this function is called from both atomic and
>>> non-atomic context, add a flag to denote whether the function may  
>>> sleep.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Cc: stable@kernel.org [3.5+]
>>> ---
>>> sound/usb/endpoint.c | 10 ++++++++--
>>> sound/usb/endpoint.h |  2 +-
>>> sound/usb/pcm.c      | 13 +++++--------
>>> 3 files changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>>> index c411812..678456c 100644
>>> --- a/sound/usb/endpoint.c
>>> +++ b/sound/usb/endpoint.c
>>> @@ -799,7 +799,9 @@ int snd_usb_endpoint_set_params(struct  
>>> snd_usb_endpoint *ep,
>>> /**
>>>  * snd_usb_endpoint_start: start an snd_usb_endpoint
>>>  *
>>> - * @ep: the endpoint to start
>>> + * @ep:		the endpoint to start
>>> + * @can_sleep:	flag indicating whether the operation is executed in
>>> + * 		non-atomic context
>>>  *
>>>  * A call to this function will increment the use count of the  
>>> endpoint.
>>>  * In case it is not already running, the URBs for this endpoint  
>>> will be
>>> @@ -809,7 +811,7 @@ int snd_usb_endpoint_set_params(struct  
>>> snd_usb_endpoint *ep,
>>>  *
>>>  * Returns an error if the URB submission failed, 0 in all other  
>>> cases.
>>>  */
>>> -int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
>>> +int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int  
>>> can_sleep)
>>> {
>>> 	int err;
>>> 	unsigned int i;
>>> @@ -821,6 +823,10 @@ int snd_usb_endpoint_start(struct  
>>> snd_usb_endpoint *ep)
>>> 	if (++ep->use_count != 1)
>>> 		return 0;
>>>
>>> +	/* just to be sure */
>>> +	deactivate_urbs(ep, 0, can_sleep);
>>> +	wait_clear_urbs(ep);
>>
>> It'd be safer to protect the call of wait_clear_urbs() when
>> can_sleep=0.
>
> Right. New patch attached.
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-ALSA-snd-usb-Fix-URB-cancellation-at-stream-start.patch
> Type: text/x-patch
> Size: 4689 bytes
> Desc: not available
> URL: <http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20120829/502d1fab/attachment-0001.bin 
> >
>
> ------------------------------
>
> Message: 4
> Date: Wed, 29 Aug 2012 15:34:35 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: "Lin, Mengdong" <mengdong.lin@intel.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Fix runtime PM
> 	accounting
> Message-ID: <s5hr4qp6cus.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
>
> At Wed, 29 Aug 2012 12:19:32 +0000,
> Lin, Mengdong wrote:
>>
>>> Now I introduced codec->epss flag that is initialized once in
>>> snd_hda_codec_new(), and let the codec driver overrides this flag.
>>> One bonus is that you can avoid the unnecessary codec parameter  
>>> read at
>>> each power change.
>>
>> Yes, this is better. And the patch works well for me - [PATCH 1/2]  
>> ALSA: hda - Avoid unnecessary parameter read for EPSS.
>>
>>> In anyway, there are a few issues:
>>> - The refcounting gets broken after module unload.  It's because we
>>>  leave the codec's pm_runtime usages after removal.
>>
>> Thanks for pointing out this! But I think the following codec can  
>> introduce risk of race among multiple codecs to modify ' chip- 
>> >power_count',
>> because only one codec's power on/off is serialized.
>> static void azx_power_notify(struct hda_bus *bus, struct hda_codec  
>> *codec)
>> {
>> 	 ...
>> 	if (codec->power_on) {
>> 		pm_runtime_get_sync(&chip->pci->dev);
>> 		chip->power_count++;
>> 	} else {
>> 		pm_runtime_put_sync(&chip->pci->dev);
>> 		chip->power_count--;
>> 	}
>> }
>>
>> How about calling pm_runtime_put_noidle() when freeing a codec in D0?
>> Maybe we can add a bus notify function like this:
>> Static void azx_codec_free_notify(struct hda_codec *codec)
>> {
>> 	If(codec->power_on)
>> 		pm_runtime_put_noidle(&codec->bus->pci->dev);
>> }
>> And snd_hda_codec_free() can trigger this notify.
>
> That's my second idea but I didn't want to introduce yet another op
> point.  But maybe it shall be the choice in the end...
>
>>> - The D3-stop-clock check isn't done properly for the codecs  
>>> providing
>>>  own set_power_state ops.
>>
>> I cannot test the branch 'if (codec->patch_ops.set_power_state)' in  
>> hda_set_power_state() for lack of such a codec.
>> But the logic seems right and the other branch works well for me :-)
>>
>>> - Ditto for the repeated power-set sequence, the error check, etc.
>> In hda_sync_power_state(),
>> 	if ((state & 0xff) == power_state)   ... should be if ((state &  
>> 0xf0)>> 4 == power_state), because PS-Act is bits 7:4
>> 		break;
>
> Ah thanks, I forgot that.
>
>> And would you please explain why changing to D3 need not wait? One  
>> of my codec does have a delay on change from D0 to D3.
>
> It was skipped because the driver doesn't need to wait.  It's just a
> power down and doesn't matter even if you proceed if you go to the
> next codec.  But as we are checking stop-clock bit, D3 should be
> sync'ed as well, indeed.  I'm going to remove the exception of D3,
> too.
>
>
> thanks,
>
> Takashi
>
>
> ------------------------------
>
> Message: 5
> Date: Wed, 29 Aug 2012 16:14:15 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: Daniel Mack <zonque@gmail.com>
> Cc: Bruno Wolff III <bruno@wolff.to>, alsa-devel@alsa-project.org,
> 	linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>
> Subject: Re: [alsa-devel] Logitech USB headset not working in 3.6-rc3
> Message-ID: <s5hoblt6b0o.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
>
> At Wed, 29 Aug 2012 15:32:34 +0200,
> Daniel Mack wrote:
>>
>> [1  <text/plain; ISO-8859-1 (7bit)>]
>> On 29.08.2012 15:29, Takashi Iwai wrote:
>>> At Wed, 29 Aug 2012 13:26:25 +0200,
>>> Daniel Mack wrote:
>>>>
>>>> [1  <text/plain; ISO-8859-1 (7bit)>]
>>>> On 25.08.2012 14:17, Josh Boyer wrote:
>>>>> On Sat, Aug 25, 2012 at 02:13:58PM +0200, Daniel Mack wrote:
>>>>>> On 25.08.2012 14:07, Bruno Wolff III wrote:
>>>>>>> On Sat, Aug 25, 2012 at 14:02:51 +0200,
>>>>>>>   Daniel Mack <zonque@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Can you revert commit e9ba389c5 ("ALSA: usb-audio: Fix
>>>>>>>> scheduling-while-atomic bug in PCM capture stream") and see  
>>>>>>>> if that
>>>>>>>
>>>>>>> I can try that, but it takes a long time to build a new kernel  
>>>>>>> on my
>>>>>>> old hardware.
>>>>>>>
>>>>>>>> helps? If not, can you summarize again which kernels still  
>>>>>>>> work for you
>>>>>>>> and which don't?
>>>>>>>
>>>>>>> The latest kernel that works is 3.6.0-0.rc2.git1.2.fc18. The  
>>>>>>> earliest that
>>>>>>> doesn't work is 3.6.0-0.rc2.git2.1.fc18.
>>>>>>>
>>>>>>
>>>>>> The report you sent doesn't look like it could be caused by  
>>>>>> e9ba389c5.
>>>>>> It fixes a kernel Ooops. But as it is the only relevant patch  
>>>>>> in that
>>>>>> area, it would be interesting if reverting it fixes anything.
>>>>>
>>>>> Yep, agreed.  If this revert kernel doesn't work, we're likely  
>>>>> down to a
>>>>> git bisect, Bruno.
>>>>>
>>>>>> Btw - thanks a lot for testing -rc kernels, much appreciated!
>>>>>
>>>>> Indeed!
>>>>
>>>> Could you please try this patch on top of Takashi's? Thanks again!
>>>>
>>>>
>>>> Daniel
>>>>
>>>> [2 0001-ALSA-snd-usb-Fix-URB-cancellation-at-stream-start.patch  
>>>> <text/x-patch (7bit)>]
>>>>> From 6617bb2463ae3fad21390b59cc2a71f96b9e9ca8 Mon Sep 17  
>>>>> 00:00:00 2001
>>>> From: Daniel Mack <zonque@gmail.com>
>>>> Date: Wed, 29 Aug 2012 13:17:05 +0200
>>>> Subject: [PATCH] ALSA: snd-usb: Fix URB cancellation at stream  
>>>> start
>>>>
>>>> Commit e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic  
>>>> bug in
>>>> PCM capture stream") fixed a scheduling-while-atomic bug that  
>>>> happened
>>>> when snd_usb_endpoint_start was called from the trigger callback,  
>>>> which
>>>> is an atmic context. However, the patch breaks the idea of the  
>>>> endpoints
>>>> reference counting, which is the reason why the driver has been
>>>> refactored lately.
>>>>
>>>> Revert that commit and let snd_usb_endpoint_start() take care of  
>>>> the URB
>>>> cancellation again. As this function is called from both atomic and
>>>> non-atomic context, add a flag to denote whether the function may  
>>>> sleep.
>>>>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>> Cc: stable@kernel.org [3.5+]
>>>> ---
>>>> sound/usb/endpoint.c | 10 ++++++++--
>>>> sound/usb/endpoint.h |  2 +-
>>>> sound/usb/pcm.c      | 13 +++++--------
>>>> 3 files changed, 14 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>>>> index c411812..678456c 100644
>>>> --- a/sound/usb/endpoint.c
>>>> +++ b/sound/usb/endpoint.c
>>>> @@ -799,7 +799,9 @@ int snd_usb_endpoint_set_params(struct  
>>>> snd_usb_endpoint *ep,
>>>> /**
>>>>  * snd_usb_endpoint_start: start an snd_usb_endpoint
>>>>  *
>>>> - * @ep: the endpoint to start
>>>> + * @ep:		the endpoint to start
>>>> + * @can_sleep:	flag indicating whether the operation is executed  
>>>> in
>>>> + * 		non-atomic context
>>>>  *
>>>>  * A call to this function will increment the use count of the  
>>>> endpoint.
>>>>  * In case it is not already running, the URBs for this endpoint  
>>>> will be
>>>> @@ -809,7 +811,7 @@ int snd_usb_endpoint_set_params(struct  
>>>> snd_usb_endpoint *ep,
>>>>  *
>>>>  * Returns an error if the URB submission failed, 0 in all other  
>>>> cases.
>>>>  */
>>>> -int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
>>>> +int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int  
>>>> can_sleep)
>>>> {
>>>> 	int err;
>>>> 	unsigned int i;
>>>> @@ -821,6 +823,10 @@ int snd_usb_endpoint_start(struct  
>>>> snd_usb_endpoint *ep)
>>>> 	if (++ep->use_count != 1)
>>>> 		return 0;
>>>>
>>>> +	/* just to be sure */
>>>> +	deactivate_urbs(ep, 0, can_sleep);
>>>> +	wait_clear_urbs(ep);
>>>
>>> It'd be safer to protect the call of wait_clear_urbs() when
>>> can_sleep=0.
>>
>> Right. New patch attached.
>
> Thanks.  This makes me thinking whether we really need to call
> deactivate_urbs() at snd_usb_endpoint_start().  deactivate_endpoints()
> is called already in prepare (at the beginning).  Which possibility is
> considered?  The comment "just to be sure" implies that my original
> code before your stream model change was simply optional.  Now I'm not
> quite sure whether we can drop it or not...
>
>
> thanks,
>
> Takashi
>
>>
>> [2 0001-ALSA-snd-usb-Fix-URB-cancellation-at-stream-start.patch  
>> <text/x-patch (7bit)>]
>>> From 42ff3e2d34427dc4c6faa09052a2531f2e71d7d6 Mon Sep 17 00:00:00  
>>> 2001
>> From: Daniel Mack <zonque@gmail.com>
>> Date: Wed, 29 Aug 2012 13:17:05 +0200
>> Subject: [PATCH] ALSA: snd-usb: Fix URB cancellation at stream start
>>
>> Commit e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic bug  
>> in
>> PCM capture stream") fixed a scheduling-while-atomic bug that  
>> happened
>> when snd_usb_endpoint_start was called from the trigger callback,  
>> which
>> is an atmic context. However, the patch breaks the idea of the  
>> endpoints
>> reference counting, which is the reason why the driver has been
>> refactored lately.
>>
>> Revert that commit and let snd_usb_endpoint_start() take care of  
>> the URB
>> cancellation again. As this function is called from both atomic and
>> non-atomic context, add a flag to denote whether the function may  
>> sleep.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: stable@kernel.org [3.5+]
>> ---
>> sound/usb/endpoint.c | 11 +++++++++--
>> sound/usb/endpoint.h |  2 +-
>> sound/usb/pcm.c      | 13 +++++--------
>> 3 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index c411812..b896c55 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -799,7 +799,9 @@ int snd_usb_endpoint_set_params(struct  
>> snd_usb_endpoint *ep,
>> /**
>>  * snd_usb_endpoint_start: start an snd_usb_endpoint
>>  *
>> - * @ep: the endpoint to start
>> + * @ep:		the endpoint to start
>> + * @can_sleep:	flag indicating whether the operation is executed in
>> + * 		non-atomic context
>>  *
>>  * A call to this function will increment the use count of the  
>> endpoint.
>>  * In case it is not already running, the URBs for this endpoint  
>> will be
>> @@ -809,7 +811,7 @@ int snd_usb_endpoint_set_params(struct  
>> snd_usb_endpoint *ep,
>>  *
>>  * Returns an error if the URB submission failed, 0 in all other  
>> cases.
>>  */
>> -int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
>> +int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int  
>> can_sleep)
>> {
>> 	int err;
>> 	unsigned int i;
>> @@ -821,6 +823,11 @@ int snd_usb_endpoint_start(struct  
>> snd_usb_endpoint *ep)
>> 	if (++ep->use_count != 1)
>> 		return 0;
>>
>> +	/* just to be sure */
>> +	deactivate_urbs(ep, 0, can_sleep);
>> +	if (can_sleep)
>> +		wait_clear_urbs(ep);
>> +
>> 	ep->active_mask = 0;
>> 	ep->unlink_mask = 0;
>> 	ep->phase = 0;
>> diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
>> index ee2723f..a8e60c1 100644
>> --- a/sound/usb/endpoint.h
>> +++ b/sound/usb/endpoint.h
>> @@ -13,7 +13,7 @@ int snd_usb_endpoint_set_params(struct  
>> snd_usb_endpoint *ep,
>> 				struct audioformat *fmt,
>> 				struct snd_usb_endpoint *sync_ep);
>>
>> -int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
>> +int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int  
>> can_sleep);
>> void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
>> 			   int force, int can_sleep, int wait);
>> int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
>> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
>> index 62ec808..1546577 100644
>> --- a/sound/usb/pcm.c
>> +++ b/sound/usb/pcm.c
>> @@ -212,7 +212,7 @@ int snd_usb_init_pitch(struct snd_usb_audio  
>> *chip, int iface,
>> 	}
>> }
>>
>> -static int start_endpoints(struct snd_usb_substream *subs)
>> +static int start_endpoints(struct snd_usb_substream *subs, int  
>> can_sleep)
>> {
>> 	int err;
>>
>> @@ -225,7 +225,7 @@ static int start_endpoints(struct  
>> snd_usb_substream *subs)
>> 		snd_printdd(KERN_DEBUG "Starting data EP @%p\n", ep);
>>
>> 		ep->data_subs = subs;
>> -		err = snd_usb_endpoint_start(ep);
>> +		err = snd_usb_endpoint_start(ep, can_sleep);
>> 		if (err < 0) {
>> 			clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags);
>> 			return err;
>> @@ -239,7 +239,7 @@ static int start_endpoints(struct  
>> snd_usb_substream *subs)
>> 		snd_printdd(KERN_DEBUG "Starting sync EP @%p\n", ep);
>>
>> 		ep->sync_slave = subs->data_endpoint;
>> -		err = snd_usb_endpoint_start(ep);
>> +		err = snd_usb_endpoint_start(ep, can_sleep);
>> 		if (err < 0) {
>> 			clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
>> 			return err;
>> @@ -544,13 +544,10 @@ static int snd_usb_pcm_prepare(struct  
>> snd_pcm_substream *substream)
>> 	subs->last_frame_number = 0;
>> 	runtime->delay = 0;
>>
>> -	/* clear the pending deactivation on the target EPs */
>> -	deactivate_endpoints(subs);
>> -
>> 	/* for playback, submit the URBs now; otherwise, the first  
>> hwptr_done
>> 	 * updates for all URBs would happen at the same time when  
>> starting */
>> 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -		return start_endpoints(subs);
>> +		return start_endpoints(subs, 1);
>>
>> 	return 0;
>> }
>> @@ -1175,7 +1172,7 @@ static int  
>> snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
>>
>> 	switch (cmd) {
>> 	case SNDRV_PCM_TRIGGER_START:
>> -		err = start_endpoints(subs);
>> +		err = start_endpoints(subs, 0);
>> 		if (err < 0)
>> 			return err;
>>
>> -- 
>> 1.7.11.4
>>
>
>
> ------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
> End of Alsa-devel Digest, Vol 66, Issue 173
> *******************************************
