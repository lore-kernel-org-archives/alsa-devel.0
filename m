From: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] ALSA: hda: runtime PM is always active
Date: Fri, 25 Jan 2019 00:31:13 +0530
Message-ID: <3475c359-34ce-c04b-24dc-79458b2b3e2a@nvidia.com>
References: <1548345432-11449-1-git-send-email-spujar@nvidia.com>
 <s5hef9211pm.wl-tiwai@suse.de>
 <770a8e0e-3e20-6997-3342-98a3656e14c1@nvidia.com>
 <s5h7eetc2x1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7eetc2x1.wl-tiwai@suse.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: abhijeet.kumar@intel.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 1/25/2019 12:13 AM, Takashi Iwai wrote:
> On Thu, 24 Jan 2019 19:15:12 +0100,
> Sameer Pujar wrote:
>>
>> On 1/24/2019 9:34 PM, Takashi Iwai wrote:
>>> On Thu, 24 Jan 2019 16:57:11 +0100,
>>> Sameer Pujar wrote:
>>>> The runtime PM count is incremented and set to active during hda codec
>>>> device init, but it is decremented and set to suspend during exit only.
>>>> Hence the runtime PM status is always active and hda device cannot be
>>>> put to runtime suspend. Keeping device usage active for entire period,
>>>> though nothing really happening on the device, seems unnecessary.
>>>>
>>>> This patch avoides incrementing runtime PM usage count of the device.
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>>>> Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
>>> This breaks the existing things, I'm afraid.
>>> Did you really test and verify the behavior...?
>>>
>>> The runtime PM refcount is decremented at snd_hda_codec_register(),
>>> and that's the place to let runtime suspend of the codec really
>>> effective.  (It's not about the controller, though.)
>>>
>> It worked fine at my end. I could put the device to runtime suspend
>> and resume it back multiple times.
>> Since you are suggesting it could break things, let me rework on the
>> patch and dig up a little more to
>> see if there is better way to fix this.
> Well, I don't see what you want to "fix".  Do you see any bug?
I was expecting the device to be runtime suspended, once probe is 
finished, until I playback something on it.
But it appears that rutntime PM is always active and runtime PM suspend 
callback never happens.
> thanks,
>
> Takashi
>
>> Thanks,
>> Sameer.
>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>
>>>> ---
>>>>    sound/hda/hdac_device.c | 6 ------
>>>>    1 file changed, 6 deletions(-)
>>>>
>>>> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
>>>> index 95b073e..72aa342 100644
>>>> --- a/sound/hda/hdac_device.c
>>>> +++ b/sound/hda/hdac_device.c
>>>> @@ -31,9 +31,6 @@ static void default_release(struct device *dev)
>>>>     *
>>>>     * Returns zero for success or a negative error code.
>>>>     *
>>>> - * This function increments the runtime PM counter and marks it active.
>>>> - * The caller needs to turn it off appropriately later.
>>>> - *
>>>>     * The caller needs to set the device's release op properly by itself.
>>>>     */
>>>>    int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>>>> @@ -55,8 +52,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>>>>    	codec->bus = bus;
>>>>    	codec->addr = addr;
>>>>    	codec->type = HDA_DEV_CORE;
>>>> -	pm_runtime_set_active(&codec->dev);
>>>> -	pm_runtime_get_noresume(&codec->dev);
>>>>    	atomic_set(&codec->in_pm, 0);
>>>>      	err = snd_hdac_bus_add_device(bus, codec);
>>>> @@ -123,7 +118,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
>>>>     */
>>>>    void snd_hdac_device_exit(struct hdac_device *codec)
>>>>    {
>>>> -	pm_runtime_put_noidle(&codec->dev);
>>>>    	snd_hdac_bus_remove_device(codec->bus, codec);
>>>>    	kfree(codec->vendor_name);
>>>>    	kfree(codec->chip_name);
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
