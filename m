From: shuah <shuah@kernel.org>
Subject: Re: [PATCH v10 0/4] Media Device Allocator API
Date: Mon, 28 Jan 2019 16:48:49 -0700
Message-ID: <481787e7-112a-80dd-228c-2497a12547b9@kernel.org>
References: <cover.1548360791.git.shuah@kernel.org>
 <e8717d11-1eff-2e07-53d5-6cd55356c66a@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e8717d11-1eff-2e07-53d5-6cd55356c66a@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On 1/28/19 5:03 AM, Hans Verkuil wrote:
> Hi Shuah,
> 
> On 1/24/19 9:32 PM, Shuah Khan wrote:
>> Media Device Allocator API to allows multiple drivers share a media device.
>> This API solves a very common use-case for media devices where one physical
>> device (an USB stick) provides both audio and video. When such media device
>> exposes a standard USB Audio class, a proprietary Video class, two or more
>> independent drivers will share a single physical USB bridge. In such cases,
>> it is necessary to coordinate access to the shared resource.
>>
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
>>
>> - This patch series is tested on 5.0-rc3 and addresses comments on
>>    v9 series from Hans Verkuil.
>> - v9 was tested on 4.20-rc6.
>> - Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
>>    arecord. When analog is streaming, digital and audio user-space
>>    applications detect that the tuner is busy and exit. When digital
>>    is streaming, analog and audio applications detect that the tuner is
>>    busy and exit. When arecord is owns the tuner, digital and analog
>>    detect that the tuner is busy and exit.
> 
> I've been doing some testing with my au0828, and I am confused about one
> thing, probably because it has been too long ago since I last looked into
> this in detail:
> 

Great.

> Why can't I change the tuner frequency if arecord (and only arecord) is
> streaming audio? If arecord is streaming, then it is recording the audio
> from the analog TV tuner, right? So changing the analog TV frequency
> should be fine.
> 

Changing analog TV frequency would be s_frequency. The way it works is
any s_* calls would require holding the pipeline. In Analog TV case, it
would mean holding both audio and video pipelines for any changes
including TV.

As I recall, we discussed this design and the decision was to make all
s_* calls interfaces to hold the tuner. A special exception is g_tuner
in case of au0828. au0828 initializes the tuner from s_* interfaces and
its g_tuner interfaces. Allowing s_frequency to proceed will disrupt the
arecord audio stream.

Query (q_*) works just fine without holding the pipeline. I limited the
analog holds to just the ones that are required. The current set is
required to avoid audio stream disruptions.

I made sure v4l-ctl --all works when the pipeline is locked by any one
of the 3 (audio, video, DVB).

Hope this helps.

thanks,
-- Shuah
