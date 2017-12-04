From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 09/15] soundwire: Add slave status
 handling
Date: Sun, 3 Dec 2017 21:52:48 -0600
Message-ID: <382cc7a0-a478-fb30-9ea4-22f828cd9093@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-10-git-send-email-vinod.koul@intel.com>
 <693f15b3-3751-2416-5d81-abd362464309@linux.intel.com>
 <20171203171139.GQ32417@localhost>
 <fb95d8f8-b6a5-6848-8b28-52e2c77a90bd@linux.intel.com>
 <20171204032059.GY32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDDB26710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 04:52:52 +0100 (CET)
In-Reply-To: <20171204032059.GY32417@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 12/3/17 9:21 PM, Vinod Koul wrote:
> On Sun, Dec 03, 2017 at 09:11:39PM -0600, Pierre-Louis Bossart wrote:
>> On 12/3/17 11:11 AM, Vinod Koul wrote:
>>> On Fri, Dec 01, 2017 at 05:52:03PM -0600, Pierre-Louis Bossart wrote:
>>>
>>>>> +		status = sdw_read(slave, SDW_DP0_INT);
>>>>> +		if (status < 0) {
>>>>> +			dev_err(slave->bus->dev,
>>>>> +				"SDW_DP0_INT read failed:%d", status);
>>>>> +			return status;
>>>>> +		}
>>>>> +
>>>>> +		count++;
>>>>> +
>>>>> +		/* we can get alerts while processing so keep retrying */
>>>>
>>>> This is not incorrect, but this goes beyond what the spec requires.
>>>>
>>>> The additional read is to make sure some interrupts are not lost due to a
>>>> known race condition. It would be enough to mask the status read the second
>>>> time to only check if the interrupts sources which were cleared are still
>>>> signaling something.
>>>>
>>>> With the code as it is, you may catch *new* interrupt sources, which could
>>>> impact the arbitration/priority/policy in handling interrupts. It's not
>>>> necessarily bad, but you'd need to document whether you want to deal with
>>>> the race condition described in the MIPI spec or try to be smarter.
>>>
>>> This was based on your last comment, lets discuss more offline on this to
>>> see what else is required here.
>>
>> I am fine if you leave the code as is for now, it's not bad but can be
>> optimized.
> 
> Not bad is not good here :)
> 
> Okay I still havent grabbed my coffee, so help me out here. I am not sure I
> understand here, can you point me to the part of spec handling you were
> referring and what should be *ideally* done

You first read the status, then clear the interrupts then re-read the 
status. I'd be good enough in the second read to mask with the settings 
of the first read. This is intended to detect alert sources that fired 
between the last successful read and the write to clear interrupts (see 
Figure 92 in the 1.1 spec)

e.g.

do {
status1= sdw_read()
deal with interrupts
status2 = sdw_read()
status2 &= status1; /* filter initial sources */
		

/* we can get alerts while processing so keep retrying */
} while (status2 != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
