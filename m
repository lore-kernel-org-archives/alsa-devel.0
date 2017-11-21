From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 3/7] ASoC: Intel: document what Kconfig
 options do
Date: Tue, 21 Nov 2017 15:32:48 -0600
Message-ID: <ad219e4f-7f54-27a9-3d07-01d9f3d5d223@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-4-pierre-louis.bossart@linux.intel.com>
 <s5hy3mztv7f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 59D89266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 22:32:51 +0100 (CET)
In-Reply-To: <s5hy3mztv7f.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, vinod.koul@intel.com, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 11/21/17 11:09 AM, Takashi Iwai wrote:
> On Sat, 18 Nov 2017 01:01:58 +0100,
> Pierre-Louis Bossart wrote:
>>
>> Document what the options are supposed to mean, before clean-up in
>> next patch.
>>
>> No functionality change here.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/Kconfig | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>> index 175b2965ca21..136426d60da0 100644
>> --- a/sound/soc/intel/Kconfig
>> +++ b/sound/soc/intel/Kconfig
>> @@ -15,16 +15,30 @@ if SND_SOC_INTEL_SST_TOPLEVEL
>>   
>>   config SND_SST_IPC
>>   	tristate
>> +	help
>> +	  This option controls the IPC core for HiFi2 platforms
> 
> A help section for non-selectable config is fine, per se, but in most
> cases it's written as a comment.

yes, I can move back to a comment. the main point was to explain the 
simplifications in the next patch
> 
> And, if we do add the help text, it's more important to do that for
> selectable items.  Currently the help texts are missing for the
> platform configs like SND_SOC_INTEL_HASWELL.

Ah, that's a miss, I did have a help but I didn't add it in the final 
RFC version. Will add in v2.

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
