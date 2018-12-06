From: shuah <shuah@kernel.org>
Subject: Re: [RFC PATCH v8 1/4] media: Media Device Allocator API
Date: Thu, 6 Dec 2018 08:33:14 -0700
Message-ID: <73c22137-9c7a-75c8-8cd1-3736c63c2d40@kernel.org>
References: <cover.1541109584.git.shuah@kernel.org>
 <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
 <20181119085931.GA28607@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119085931.GA28607@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/19/18 1:59 AM, Pavel Machek wrote:
> On Thu 2018-11-01 18:31:30, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Media Device Allocator API to allows multiple drivers share a media device.
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
> 
> Sounds like a ... bad idea?
> 
> That's what new "media control" framework is for, no?
> 
> Why do you need this?
> 								Pavel
> 

Media control framework doesn't address this problem of ownership of the 
media device when non-media drivers have to own the pipeline. In this 
case, snd-usb owns the audio pipeline when an audio application is using 
the device. Without this work, media drivers won't be able to tell if 
snd-usb is using the tuner and owns the media pipeline.

I am going to clarify this in the commit log.

thanks,
-- Shuah
