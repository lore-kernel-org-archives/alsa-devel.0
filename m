From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v10 0/4] Media Device Allocator API
Date: Wed, 6 Feb 2019 08:36:01 +0100
Message-ID: <57eae510-b8cb-b859-a1d6-1e716b869ba1@xs4all.nl>
References: <cover.1548360791.git.shuah@kernel.org>
 <e8717d11-1eff-2e07-53d5-6cd55356c66a@xs4all.nl>
 <481787e7-112a-80dd-228c-2497a12547b9@kernel.org>
 <d9ae1073-f6a9-1085-c8f8-8edd05daece5@xs4all.nl>
 <b9a62121-8ab0-5c1c-79ff-8bb39fc8b762@kernel.org>
 <fe6d6f63-72e3-8e2f-462d-b029997d8ee9@xs4all.nl>
 <7a809bc8-f75e-04e6-f612-f6111c6b5a71@kernel.org>
 <7e6dc7f1-f596-22d7-bdd6-b54bd912a40d@xs4all.nl>
 <80c87e59-bf25-d470-1566-c6aa60e9b0ed@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80c87e59-bf25-d470-1566-c6aa60e9b0ed@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: shuah <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2/5/19 7:10 PM, shuah wrote:
> On 2/1/19 2:21 AM, Hans Verkuil wrote:
>> On 2/1/19 1:46 AM, shuah wrote:
>>> Hi Hans,
>>>
>>> On 1/30/19 12:42 AM, Hans Verkuil wrote:
>>>> On 1/30/19 2:50 AM, shuah wrote:
>>>>> On 1/29/19 2:43 AM, Hans Verkuil wrote:
>>>>>> On 1/29/19 12:48 AM, shuah wrote:
>>>>>>> Hi Hans,
>>>>>>>
>>>>>>> On 1/28/19 5:03 AM, Hans Verkuil wrote:
>>>>>>>> Hi Shuah,
>>>>>>>>
>>>>>>>> On 1/24/19 9:32 PM, Shuah Khan wrote:
>>>>>>>>> Media Device Allocator API to allows multiple drivers share a media device.
>>>>>>>>> This API solves a very common use-case for media devices where one physical
>>>>>>>>> device (an USB stick) provides both audio and video. When such media device
>>>>>>>>> exposes a standard USB Audio class, a proprietary Video class, two or more
>>>>>>>>> independent drivers will share a single physical USB bridge. In such cases,
>>>>>>>>> it is necessary to coordinate access to the shared resource.
>>>>>>>>>
>>>>>>>>> Using this API, drivers can allocate a media device with the shared struct
>>>>>>>>> device as the key. Once the media device is allocated by a driver, other
>>>>>>>>> drivers can get a reference to it. The media device is released when all
>>>>>>>>> the references are released.
>>>>>>>>>
>>>>>>>>> - This patch series is tested on 5.0-rc3 and addresses comments on
>>>>>>>>>       v9 series from Hans Verkuil.
>>>>>>>>> - v9 was tested on 4.20-rc6.
>>>>>>>>> - Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
>>>>>>>>>       arecord. When analog is streaming, digital and audio user-space
>>>>>>>>>       applications detect that the tuner is busy and exit. When digital
>>>>>>>>>       is streaming, analog and audio applications detect that the tuner is
>>>>>>>>>       busy and exit. When arecord is owns the tuner, digital and analog
>>>>>>>>>       detect that the tuner is busy and exit.
>>>>>>>>
>>>>>>>> I've been doing some testing with my au0828, and I am confused about one
>>>>>>>> thing, probably because it has been too long ago since I last looked into
>>>>>>>> this in detail:
>>>>>>>>
>>>>>>>
>>>>>>> Great.
>>>>>>>
>>>>>>>> Why can't I change the tuner frequency if arecord (and only arecord) is
>>>>>>>> streaming audio? If arecord is streaming, then it is recording the audio
>>>>>>>> from the analog TV tuner, right? So changing the analog TV frequency
>>>>>>>> should be fine.
>>>>>>>>
>>>>>>>
>>>>>>> Changing analog TV frequency would be s_frequency. The way it works is
>>>>>>> any s_* calls would require holding the pipeline. In Analog TV case, it
>>>>>>> would mean holding both audio and video pipelines for any changes
>>>>>>> including TV.
>>>>>>>
>>>>>>> As I recall, we discussed this design and the decision was to make all
>>>>>>> s_* calls interfaces to hold the tuner. A special exception is g_tuner
>>>>>>> in case of au0828. au0828 initializes the tuner from s_* interfaces and
>>>>>>> its g_tuner interfaces. Allowing s_frequency to proceed will disrupt the
>>>>>>> arecord audio stream.
>>>>>>>
>>>>>>> Query (q_*) works just fine without holding the pipeline. I limited the
>>>>>>> analog holds to just the ones that are required. The current set is
>>>>>>> required to avoid audio stream disruptions.
>>>>>>
>>>>>> So I am not sure about that ('avoid audio stream disruptions'): if I
>>>>>> stream video AND use arecord, then I can just set the frequency while
>>>>>> streaming. Doesn't that interrupt audio as well? And are you sure changing
>>>>>> the tuner frequency actually disrupts audio? And if audio is disrupted,
>>>>>> are we talking about a glitch or is audio permanently disrupted?
>>>>>
>>>>> I think it is a glitch. I will run some tests and let you know.
>>>>>>
>>>>>> That's basically the inconsistent behavior I noticed: just running arecord
>>>>>> will prevent me from changing the frequency, but if I run arecord and stream
>>>>>> video, then it is suddenly OK to change the frequency.
>>>>>
>>>>> How are you changing frequency? I want to duplicate what you are doing.
>>>>
>>>> v4l2-ctl -f <freq>
>>>
>>> I am not seeing the inconsistent behavior. Here are my results.
>>>
>>> 1. Started acecord and while it is running:
>>>
>>> arecord -M -D plughw:2,0 -c2  -f S16_LE -t wav foo.wav
>>> Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
>>>
>>> 2. Ran v4l2-ctl -f as follows:
>>>
>>> v4l2-ctl -f 700
>>> VIDIOC_G_TUNER: failed: Device or resource busy
>>> VIDIOC_S_FREQUENCY: failed: Device or resource busy
>>>
>>> Based on the current implementation, it failed with resource
>>> busy as expected.
>>>
>>> 3. Started v4l2-ctl as follows:
>>>
>>>   v4l2-ctl --stream-mmap --stream-count=100 -d /dev/video0
>>> VIDIOC_STREAMON: failed: Device or resource busy
>>
>> Why is this? You have one analog tuner and it delivers independent audio
>> and video streams. I should be able to start/stop audio and video independently.
>>
>> And as mentioned above, if I use v4l2-ctl for video streaming, then start arecord,
>> then that works fine. And I can change the tuner frequency while both are streaming.
>>
>> But doing this the other way around (first start arecord, then v4l2-ctl) then that
>> doesn't work.
>>
>> It makes no sense.
>>
>> Note that v4l2-ctl does not open audio, it solely deals with video. qv4l2 will
>> open both audio and video, but for testing audio and video independently you
>> need to use arecord/v4l2-ctl.
>>
>> In any case, my understanding of how this should work is that both arecord and
>> v4l2-ctl should attempt to lock the analog tuner resource, but they can share it.
>>
>> If DVB is using the tuner, then both arecord and v4l2-ctl should fail with -EBUSY.
>> Same if either of arecord/v4l2-ctl is running, then DVB should fail with -EBUSY.
>>
>> BTW, I won't be able to test anything myself until Feb 9th since I'm abroad and
>> don't have access to my au0828.
>>
> 
> I am also on a business trip at the moment and won't have access to my
> au0828 until Feb 8th.
> 
> I think I understand your concern and the change to get the desired behavior of allowing tuner to be shared by arecord and v4l2-ctl is
> going to in the code that is already in the mainline which is the
> au0828_enable_source().
> 
> If you would like to wait to pull this series for the problem to be fixed, I can send that change in. It will be another patch added to
> the series.
> 
> Or if you pull this and I can send fix on top. Let me know your preference.

I prefer to wait until I can test with the additional patch if that's OK?

Regards,

	Hans
