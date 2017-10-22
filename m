From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 04/14] soundwire: Add MIPI DisCo property
 helpers
Date: Sun, 22 Oct 2017 15:44:47 +0530
Message-ID: <bfbe69a1-e1dd-de1a-52b9-8de48190bc0b@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-5-git-send-email-vinod.koul@intel.com>
 <20171021092046.p6wsssjkonjjdidt@sirena.org.uk>
 <20171021113718.GG30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7310E266D69
 for <alsa-devel@alsa-project.org>; Sun, 22 Oct 2017 12:14:54 +0200 (CEST)
In-Reply-To: <20171021113718.GG30097@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 10/21/17 5:07 PM, Vinod Koul wrote:
> On Sat, Oct 21, 2017 at 10:20:46AM +0100, Mark Brown wrote:
>> On Thu, Oct 19, 2017 at 08:33:20AM +0530, Vinod Koul wrote:
>>
>>> +	/* device is probed so let's read the properties now */
>>> +	if (slave->ops && slave->ops->read_prop)
>>> +		slave->ops->read_prop(slave);
>>
>> Is it valid for us to not be able to read the properties?
> 
> Practically no. Without the values bus wont work

The notion of read is a bit overloaded here. What is needed is that the 
information is provided to the bus, whether you read it from firmware or 
a table in the codec driver is an implementation choice - see below.
> 
>>
>>> +		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
>>> +						&dpn[i].max_word);
>>> +		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
>>> +						&dpn[i].min_word);
>>
>> Don't we know this stuff simply by virtue of knowing what device we're
>> talking to (given that there aren't class devices)?
> 
> Well I think the spec is midway to device class so they added it to make it
> generic :)

The properties are needed so that the bus can perform all the 
transport-related stuff. As explained in the patches, we are not making 
assumptions on how the codec driver is written, the implementation can 
either get the properties from firmware (DT or ACPI) or hard-code them 
in the driver.

The only property that needs to be defined is for multi-lane setups, 
since the topology is not known to a codec driver.
