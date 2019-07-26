From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 27/40] soundwire: Add Intel resource
 management algorithm
Date: Fri, 26 Jul 2019 09:41:02 -0500
Message-ID: <a1da9937-0e20-d83d-ec90-c3fd9f3fbeca@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
 <869edbf2-1fdd-6b21-818f-20c39c013c11@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <869edbf2-1fdd-6b21-818f-20c39c013c11@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 6:07 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> This algorithm computes bus parameters like clock frequency, frame
>> shape and port transport parameters based on active stream(s) running
>> on the bus.
>>
>> This implementation is optimal for Intel platforms. Developers can
>> also implement their own .compute_params() callback for specific
>> resource management algorithm.
>>
>> Credits: this patch is based on an earlier internal contribution by
>> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
>> values were removed from the initial contribution to use BIOS
>> information instead.
>>
>> FIXME: remove checkpatch report
>> WARNING: Reusing the krealloc arg is almost always a bug
>> +            group->rates = krealloc(group->rates,
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> Could you specify the requirements and limitations for this algorithm? 
> Last year I written calc for Linux based on Windows (please don't burn 
> me here) equivalent though said requirements/ limitiations might have 
> changed and nothing is valid any longer.

The frame shape typically only changes by doubling the number of 
columns, and the priority is given to PDM streams which use columns. 
It's hard to document this on a public mailing list, it'd require making 
references to a spec that's only available to MIPI members.

> 
> I remember that some parts of specification overcomplicated the 
> calculator and due to actual, realtime usecases it could be greatly 
> simplified (that's why I mention that my work is probably no longer 
> valid). However, these details would help me in reviewing your 
> implementation and providing suggestions.

To the best of my knowledge, the algorithm follows a script that is used 
for both Windows and Linux. The code was initially written by Vinod and 
team, and I am not aware of simplifications.
There a simplifications that are possible, e.g. we don't support PDM for 
now and the notion of grouping is not needed, but we have to carefully 
balance 'optimization' with 'introducing bugs'. if this algorithm craps 
out then the entire bus operation is in the weeds.

If we really want people to experiment and get a feel for the 
performance of the algorithm, we should really provide a UI where the 
stream parameters can be entered and visually check what the algorithm 
is doing. I have a solution that shows the bits based on the stream 
parameters (need to make it available e.g. in Python), if we connected 
it with the automatic bit allocation it'd be very useful.

> And yes, "Frame shape calculator" probably suits this better.
> Though this might be just a preference thingy : )

Resource management is indeed a bit vague. But frame shape calculator is 
not quite right. The algorithm will find the frame shape that is 
required for the current bandwidth, but will also allocate the bitSlots 
in that frame. In MIPI circles we talk about bitSlot allocation.
