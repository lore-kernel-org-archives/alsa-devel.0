From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] [PATCH] ASoC: acpi: fix machine driver
 selection based on quirk
Date: Thu, 4 Jan 2018 09:18:23 -0600
Message-ID: <dbd1e594-9c6f-2780-2a9d-081214e48dd9@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
 <20180103170242.5363-2-pierre-louis.bossart@linux.intel.com>
 <1515071329.7000.668.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B0432678B8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 16:18:22 +0100 (CET)
In-Reply-To: <1515071329.7000.668.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 1/4/18 7:08 AM, Andy Shevchenko wrote:
> On Wed, 2018-01-03 at 11:02 -0600, Pierre-Louis Bossart wrote:
>> The ACPI/machine-driver code refactoring introduced in 4.13 introduced
>> a regression for cases where we need a DMI-based quirk to select the
>> machine driver (the BIOS reports an invalid HID). The fix is just to
>> make sure the results of the quirk are actually used.
>>
> 
>>   	for (mach = machines; mach->id[0]; mach++) {
>>   		if (snd_soc_acpi_check_hid(mach->id) == true) {
>>   			if (mach->machine_quirk(mach) != NULL)
> 
> Just a nit: perhaps use more natural style, i.e. drop " != NULL" part
> off?

ok.

> 
>> +				mach = mach->machine_quirk(mach);
>> +			return mach;
>>   		}
>>   	}
>>   	return NULL;
> 
