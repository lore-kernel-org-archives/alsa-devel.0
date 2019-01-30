From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v10 0/4] Media Device Allocator API
Date: Wed, 30 Jan 2019 08:42:17 +0100
Message-ID: <fe6d6f63-72e3-8e2f-462d-b029997d8ee9@xs4all.nl>
References: <cover.1548360791.git.shuah@kernel.org>
 <e8717d11-1eff-2e07-53d5-6cd55356c66a@xs4all.nl>
 <481787e7-112a-80dd-228c-2497a12547b9@kernel.org>
 <d9ae1073-f6a9-1085-c8f8-8edd05daece5@xs4all.nl>
 <b9a62121-8ab0-5c1c-79ff-8bb39fc8b762@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud7.xs4all.net (lb3-smtp-cloud7.xs4all.net
 [194.109.24.31])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5812666B3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 08:42:22 +0100 (CET)
In-Reply-To: <b9a62121-8ab0-5c1c-79ff-8bb39fc8b762@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shuah <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 1/30/19 2:50 AM, shuah wrote:
> On 1/29/19 2:43 AM, Hans Verkuil wrote:
>> On 1/29/19 12:48 AM, shuah wrote:
>>> Hi Hans,
>>>
>>> On 1/28/19 5:03 AM, Hans Verkuil wrote:
>>>> Hi Shuah,
>>>>
>>>> On 1/24/19 9:32 PM, Shuah Khan wrote:
>>>>> Media Device Allocator API to allows multiple drivers share a media device.
>>>>> This API solves a very common use-case for media devices where one physical
>>>>> device (an USB stick) provides both audio and video. When such media device
>>>>> exposes a standard USB Audio class, a proprietary Video class, two or more
>>>>> independent drivers will share a single physical USB bridge. In such cases,
>>>>> it is necessary to coordinate access to the shared resource.
>>>>>
>>>>> Using this API, drivers can allocate a media device with the shared struct
>>>>> device as the key. Once the media device is allocated by a driver, other
>>>>> drivers can get a reference to it. The media device is released when all
>>>>> the references are released.
>>>>>
>>>>> - This patch series is tested on 5.0-rc3 and addresses comments on
>>>>>     v9 series from Hans Verkuil.
>>>>> - v9 was tested on 4.20-rc6.
>>>>> - Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
>>>>>     arecord. When analog is streaming, digital and audio user-space
>>>>>     applications detect that the tuner is busy and exit. When digital
>>>>>     is streaming, analog and audio applications detect that the tuner is
>>>>>     busy and exit. When arecord is owns the tuner, digital and analog
>>>>>     detect that the tuner is busy and exit.
>>>>
>>>> I've been doing some testing with my au0828, and I am confused about one
>>>> thing, probably because it has been too long ago since I last looked into
>>>> this in detail:
>>>>
>>>
>>> Great.
>>>
>>>> Why can't I change the tuner frequency if arecord (and only arecord) is
>>>> streaming audio? If arecord is streaming, then it is recording the audio
>>>> from the analog TV tuner, right? So changing the analog TV frequency
>>>> should be fine.
>>>>
>>>
>>> Changing analog TV frequency would be s_frequency. The way it works is
>>> any s_* calls would require holding the pipeline. In Analog TV case, it
>>> would mean holding both audio and video pipelines for any changes
>>> including TV.
>>>
>>> As I recall, we discussed this design and the decision was to make all
>>> s_* calls interfaces to hold the tuner. A special exception is g_tuner
>>> in case of au0828. au0828 initializes the tuner from s_* interfaces and
>>> its g_tuner interfaces. Allowing s_frequency to proceed will disrupt the
>>> arecord audio stream.
>>>
>>> Query (q_*) works just fine without holding the pipeline. I limited the
>>> analog holds to just the ones that are required. The current set is
>>> required to avoid audio stream disruptions.
>>
>> So I am not sure about that ('avoid audio stream disruptions'): if I
>> stream video AND use arecord, then I can just set the frequency while
>> streaming. Doesn't that interrupt audio as well? And are you sure changing
>> the tuner frequency actually disrupts audio? And if audio is disrupted,
>> are we talking about a glitch or is audio permanently disrupted?
> 
> I think it is a glitch. I will run some tests and let you know.
>>
>> That's basically the inconsistent behavior I noticed: just running arecord
>> will prevent me from changing the frequency, but if I run arecord and stream
>> video, then it is suddenly OK to change the frequency.
> 
> How are you changing frequency? I want to duplicate what you are doing.

v4l2-ctl -f <freq>

> 
>>
>> BTW, I think there was also inconsistent behavior in the order of streaming
>> audio and video: if I stream video first, then I can stream audio afterwards.
>> But if I stream audio first, then (if I remember correctly) I can't start
>> video streaming.
>>
> 
> I will run some tests tomorrow and see what I find. Which video apps are
> you running for these tests?

v4l2-ctl or qv4l2.

Regards,

	Hans

> 
> thanks,
> -- Shuah
> 
