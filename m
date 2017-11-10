From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 10 Nov 2017 10:50:03 +0000
Message-ID: <702d9153-69c5-c574-6ea3-fd2b54f23cf0@linaro.org>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <5fee4ccb-1030-b698-e7ef-7f4390563a76@linaro.org>
 <20171110045951.GL3187@localhost> <20171110085537.GQ3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110085537.GQ3187@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 10/11/17 08:55, Vinod Koul wrote:
>>>> +
>>>> +/**
>>>> + * sdw_get_device_id: find the matching SoundWire device id
>>>> + *
>>> function name should end with () - according to kernel doc.
>> ah thanks for pointing will add
> I ran the kernel-doc script, seems to not complain about this.
> 
> Looking at it closely scripts/kernel-doc parenthesis is not expected

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?h=v4.14-rc8#n204

Examples in the doc does suggest that we need (). Am not 100% sure if : 
is also a valid with functions.
