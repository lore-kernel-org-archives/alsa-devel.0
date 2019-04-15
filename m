From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 0/5] soundwire: code cleanup
Date: Mon, 15 Apr 2019 07:57:03 -0500
Message-ID: <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190414100417.GH28103@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190414100417.GH28103@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org



On 4/14/19 5:04 AM, Vinod Koul wrote:
> On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
>> SoundWire support will be provided in Linux with the Sound Open
>> Firmware (SOF) on Intel platforms. Before we start adding the missing
>> pieces, there are a number of warnings and style issues reported by
>> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Applied, 1, 3 and 4 (5 looked good but didnt apply)

this applies on top of Mark Brown's for-next tree. This should be the 
reference really for SoundWire work, if we start having another tree 
with deltas it's really counter productive. I already have dependencies 
on acpi...
