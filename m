From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 03/15] soundwire: Add Master registration
Date: Sun, 3 Dec 2017 20:44:58 -0600
Message-ID: <8920a633-4635-afbb-18c4-2a826facd2eb@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-4-git-send-email-vinod.koul@intel.com>
 <435d9db4-eb3c-f4b4-d978-e5d10b921f71@linux.intel.com>
 <20171203164119.GL32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171203164119.GL32417@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


>>> +/* SDW Enumeration Device Number */
>>> +#define SDW_ENUM_DEV_NUM		0
>>
>> add
>> SDW_GROUP12_DEV_NUM		12
>> SDW_GROUP12_DEV_NUM		13
> 
> you mean SDW_GROUP13_DEV_NUM :D
> 
>> SDW_MASTER_DEV_NUM		14 /* not supported in these patches */
> 
> These dont help now as we dont support, so kind of dead code.
> Lets add them when we really support it

It was a way to explain why device 14 is never allocated.
