From: shuah <shuah@kernel.org>
Subject: Re: [alsa-devel] [PATCH v9 4/4] sound/usb: Use Media Controller API
 to share media resources
Date: Fri, 11 Jan 2019 08:04:00 -0700
Message-ID: <bdc38535-624f-4208-6f34-a021145a4938@kernel.org>
References: <cover.1545154777.git.shuah@kernel.org>
 <2fb40852e4035b2a58010ce7416448918f12804f.1545154778.git.shuah@kernel.org>
 <s5hefadbp5m.wl-tiwai@suse.de>
 <5f9588b5-657a-78ee-9614-ed0ef1fc5839@kernel.org>
 <f13637a7-5c15-ba43-9929-78fef09e54fb@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f13637a7-5c15-ba43-9929-78fef09e54fb@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 1/11/19 7:59 AM, Hans Verkuil wrote:
> On 1/11/19 3:57 PM, shuah wrote:
>> On 12/19/18 6:51 AM, Takashi Iwai wrote:
>>> On Tue, 18 Dec 2018 18:59:39 +0100,
>>> shuah@kernel.org wrote:
>>>>
>>>> From: Shuah Khan <shuah@kernel.org>
>>>>
>>>> Media Device Allocator API to allows multiple drivers share a media device.
>>>> This API solves a very common use-case for media devices where one physical
>>>> device (an USB stick) provides both audio and video. When such media device
>>>> exposes a standard USB Audio class, a proprietary Video class, two or more
>>>> independent drivers will share a single physical USB bridge. In such cases,
>>>> it is necessary to coordinate access to the shared resource.
>>>>
>>>> Using this API, drivers can allocate a media device with the shared struct
>>>> device as the key. Once the media device is allocated by a driver, other
>>>> drivers can get a reference to it. The media device is released when all
>>>> the references are released.
>>>>
>>>> Change the ALSA driver to use the Media Controller API to share media
>>>> resources with DVB, and V4L2 drivers on a AU0828 media device.
>>>>
>>>> The Media Controller specific initialization is done after sound card is
>>>> registered. ALSA creates Media interface and entity function graph nodes
>>>> for Control, Mixer, PCM Playback, and PCM Capture devices.
>>>>
>>>> snd_usb_hw_params() will call Media Controller enable source handler
>>>> interface to request the media resource. If resource request is granted,
>>>> it will release it from snd_usb_hw_free(). If resource is busy, -EBUSY is
>>>> returned.
>>>>
>>>> Media specific cleanup is done in usb_audio_disconnect().
>>>>
>>>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>>>
>>> Feel free to take my ack regarding the sound stuff:
>>>     Reviewed-by: Takashi Iwai <tiwai@suse.de>
>>>
>>>
>>> Thanks!
>>>
>>> Takashi
>>>
>>
>> Hi Mauro,
>>
>> Any update on this patch series?
> 
> I'm planning to process this series for 5.1. Haven't gotten around to it yet,
> but I expect to do this next week.
> 
> Still going through all the pending patches after the Christmas period :-)
> 
> Regards,
> 
> 	Hans
> 

Hans,

Thanks for a quick reply. No worries. I am recovering from the Christmas
and vacation myself. :)

thanks,
-- Shuah
