From: shuah <shuah@kernel.org>
Subject: Re: [PATCH v15 0/6] Media Device Allocator API
Date: Tue, 2 Apr 2019 08:38:56 -0600
Message-ID: <829089d0-8cef-bce5-6717-9a39522f7be1@kernel.org>
References: <cover.1554155701.git.shuah@kernel.org>
 <fb0b46d3-a8a5-c5b5-7f3e-08ddfd27235b@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fb0b46d3-a8a5-c5b5-7f3e-08ddfd27235b@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 4/2/19 1:38 AM, Hans Verkuil wrote:
> On 4/2/19 2:40 AM, Shuah Khan wrote:
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
>> The primary focus for testing The patch series is making sure media
>> device is released when both drivers release the media device with
>> a series of unbind/binds on both drivers.
>>
>> - both au0828 and snd-usb-aduio as built-in
>> - both au0828 and snd-usb-aduio as modules
>> - au0828 as module and snd-usb-aduio as built-in
>> - au0828 as built-in and snd-usb-aduio as module
>>
>> Test results can be found at:
>>
>> https://docs.google.com/document/d/1RMF8Rwj7xHJEoOx6_K2f-REgZJ63BMeAVEf-CV-0HsM/edit?usp=sharing
> 
> Phew, after posting v2 of my patch "au0828: stop video streaming only when last
> user stops" everything now works as it should, including the issue with two VBI
> streams you found.
> 

Awesome. Thanks for taking care of this. Looks good. I tested the
patch and sent Tested-by for it.

> Should I take the selftest patch or will you take that yourself?

Please take this through your pull request. Bundling the test with the
feature will help promote use of this test :)

Please pick up the null pointer dereference fix in bind path when unbind
happens while bind is in progress.

> 
> Let me know so I can make the pull request for this. It's been a long journey
> since the first post on April 9th, 2014: "[RFC PATCH 0/2] managed token devres
> interfaces".
>

Please send the pull request.

> Almost exactly five years of work!
> 
Amazing. We ended up with a far better solution than the the first patch
series ! Thanks to everybody that helped me with reviews and testing.

thanks,
-- Shuah
