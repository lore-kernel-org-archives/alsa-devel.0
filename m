From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 08/14] soundwire: Add Slave status handling
 helpers
Date: Wed, 1 Nov 2017 02:49:15 +0530
Message-ID: <98f1b39a-b48d-2603-8e9d-88b4f804e2c8@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-9-git-send-email-vinod.koul@intel.com>
 <s5h60bbqmkz.wl-tiwai@suse.de> <20171031130412.GW3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A4DDC266B38
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 22:19:24 +0100 (CET)
In-Reply-To: <20171031130412.GW3187@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


> 
>>> +		if (found == false) {
>>> +			/* TODO: Park this device in Group 13 */
>>> +			dev_err(bus->dev, "Slave Entry not found");
>>
>> No break here?  Otherwise...
> 
> Thats intentional. We want to still read next device that show up
> 
>>
>>> +		}
>>> +
>>> +	} while (ret == 0);
>>
>> ... the outer loop may go endlessly.
>> This condition doesn't look effective.
> 
> not really. We cant keep reading successfully. At some point all slaves will
> ignore and return ENODATA and we exit. Bus errors will also make it exit
> 
> BUT given that we have seen stuff i am inclined to add a counter, we cant
> have more than 11 device so that's a sane value to use :)

Yep. Keep in mind however that there could be theoretical corner cases: 
if a device is enumerated, loses sync and becomes attached again while 
you deal with others, you'd have more than 11 iterations.
