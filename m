From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v9 4/4] sound/usb: Use Media Controller API to share media
 resources
Date: Sat, 19 Jan 2019 11:30:27 +0100
Message-ID: <7719a35c-c65e-977e-88b8-693d55e88723@xs4all.nl>
References: <cover.1545154777.git.shuah@kernel.org>
 <2fb40852e4035b2a58010ce7416448918f12804f.1545154778.git.shuah@kernel.org>
 <b2fddc47-94c6-b7b3-8304-55905a3e278d@xs4all.nl>
 <ee9b4161-eeb8-340f-7b39-93d0bc5fe1bd@kernel.org>
 <8593299c-b80f-d1d3-9a03-d56fb1573f60@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8593299c-b80f-d1d3-9a03-d56fb1573f60@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: shuah <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/19/2019 02:03 AM, shuah wrote:
> On 1/18/19 2:54 PM, shuah wrote:
>> On 1/18/19 1:36 AM, Hans Verkuil wrote:
>>> On 12/18/18 6:59 PM, shuah@kernel.org wrote:
>>>> From: Shuah Khan <shuah@kernel.org>
>>>>
>>>> Media Device Allocator API to allows multiple drivers share a media 
>>>> device.
>>>> This API solves a very common use-case for media devices where one 
>>>> physical
>>>> device (an USB stick) provides both audio and video. When such media 
>>>> device
>>>> exposes a standard USB Audio class, a proprietary Video class, two or 
>>>> more
>>>> independent drivers will share a single physical USB bridge. In such 
>>>> cases,
>>>> it is necessary to coordinate access to the shared resource.
>>>>
>>>> Using this API, drivers can allocate a media device with the shared 
>>>> struct
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
>>>> it will release it from snd_usb_hw_free(). If resource is busy, 
>>>> -EBUSY is
>>>> returned.
>>>>
>>>> Media specific cleanup is done in usb_audio_disconnect().
>>>>
>>>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>>>> ---
>>>>   sound/usb/Kconfig        |   4 +
>>>>   sound/usb/Makefile       |   2 +
>>>>   sound/usb/card.c         |  14 ++
>>>>   sound/usb/card.h         |   3 +
>>>>   sound/usb/media.c        | 321 +++++++++++++++++++++++++++++++++++++++
>>>>   sound/usb/media.h        |  74 +++++++++
>>>>   sound/usb/mixer.h        |   3 +
>>>>   sound/usb/pcm.c          |  29 +++-
>>>>   sound/usb/quirks-table.h |   1 +
>>>>   sound/usb/stream.c       |   2 +
>>>>   sound/usb/usbaudio.h     |   6 +
>>>>   11 files changed, 455 insertions(+), 4 deletions(-)
>>>>   create mode 100644 sound/usb/media.c
>>>>   create mode 100644 sound/usb/media.h
>>>>
>>>
>>> <snip>
>>>
>>>> +int snd_media_device_create(struct snd_usb_audio *chip,
>>>> +            struct usb_interface *iface)
>>>> +{
>>>> +    struct media_device *mdev;
>>>> +    struct usb_device *usbdev = interface_to_usbdev(iface);
>>>> +    int ret;
>>>> +
>>>> +    /* usb-audio driver is probed for each usb interface, and
>>>> +     * there are multiple interfaces per device. Avoid calling
>>>> +     * media_device_usb_allocate() each time usb_audio_probe()
>>>> +     * is called. Do it only once.
>>>> +     */
>>>> +    if (chip->media_dev)
>>>> +        goto snd_mixer_init;
>>>> +
>>>> +    mdev = media_device_usb_allocate(usbdev, KBUILD_MODNAME);
>>>> +    if (!mdev)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (!media_devnode_is_registered(mdev->devnode)) {
>>>
>>> It looks like you missed my comment for v8:
>>>
>>> "You should first configure the media device before registering it."
>>>
>>> In other words, first create the media entities, and only then do you
>>> register the media device. Otherwise it will come up without any alsa
>>> entities, which are then added. So an application that immediately
>>> opens the media device upon creation will see a topology that is still
>>> in flux.
>>
>> Yes. You are right. I saw your comment and thought I got it addressed.
>> I will fix it. I have the logic correct in au0828, but not here.
>>
> 
> One thing to mention here is some ALSA entities get created dynamically
> during PCM open when stream is initialized. This happens after media
> device is registered. These get deleted when pcm close happens. There is
> no way to avoid creating entities after media device register.

That's OK. We're missing some infrastructure (media events) to inform the
application about topology changes.

But when registering the media device for the first time it is good practice
to do that after creating all the entities that you can.

Regards,

	Hans

> snd_media_device_create() could get called after media_device_register()
> happens, if au0828 registers it first.
> 
> I did find a problem in snd_media_device_create() and I will send a v10
> with that fix.
> 
> thanks,
> -- Shuah
> 
