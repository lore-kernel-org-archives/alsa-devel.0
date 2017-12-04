From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 09/15] soundwire: Add slave status
 handling
Date: Sun, 3 Dec 2017 21:11:39 -0600
Message-ID: <fb95d8f8-b6a5-6848-8b28-52e2c77a90bd@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-10-git-send-email-vinod.koul@intel.com>
 <693f15b3-3751-2416-5d81-abd362464309@linux.intel.com>
 <20171203171139.GQ32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171203171139.GQ32417@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 12/3/17 11:11 AM, Vinod Koul wrote:
> On Fri, Dec 01, 2017 at 05:52:03PM -0600, Pierre-Louis Bossart wrote:
> 
>>> +		status = sdw_read(slave, SDW_DP0_INT);
>>> +		if (status < 0) {
>>> +			dev_err(slave->bus->dev,
>>> +				"SDW_DP0_INT read failed:%d", status);
>>> +			return status;
>>> +		}
>>> +
>>> +		count++;
>>> +
>>> +		/* we can get alerts while processing so keep retrying */
>>
>> This is not incorrect, but this goes beyond what the spec requires.
>>
>> The additional read is to make sure some interrupts are not lost due to a
>> known race condition. It would be enough to mask the status read the second
>> time to only check if the interrupts sources which were cleared are still
>> signaling something.
>>
>> With the code as it is, you may catch *new* interrupt sources, which could
>> impact the arbitration/priority/policy in handling interrupts. It's not
>> necessarily bad, but you'd need to document whether you want to deal with
>> the race condition described in the MIPI spec or try to be smarter.
> 
> This was based on your last comment, lets discuss more offline on this to
> see what else is required here.
> 

I am fine if you leave the code as is for now, it's not bad but can be 
optimized.
