From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Intel: Update broxton machine
	driver
Date: Tue, 12 Feb 2019 15:17:49 -0600
Message-ID: <fcde7af0-8f45-2bcb-9eb7-960154a0d974@linux.intel.com>
References: <1548268717-32596-1-git-send-email-yong.zhi@intel.com>
 <7b33f032-2bfe-ad13-1cd7-7547de389bfd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D312673E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 22:17:52 +0100 (CET)
In-Reply-To: <7b33f032-2bfe-ad13-1cd7-7547de389bfd@linux.intel.com>
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
To: Yong Zhi <yong.zhi@intel.com>, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, naveen.m@intel.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


On 1/23/19 4:23 PM, Pierre-Louis Bossart wrote:
>
>
> On 1/23/19 12:38 PM, Yong Zhi wrote:
>> Hello,
>>
>> This patchset is an update to the following v2 posted by Naveen last year:
>>
>> https://patchwork.kernel.org/patch/10335295/
>> https://patchwork.kernel.org/patch/10335293/
>> https://patchwork.kernel.org/patch/10335297/
>>
>> 1/5 and 5/5 of original series were merged. The changes have been tested for
>> both bxt_da7219_max98357a and glk_da7219_max98357a.
>>
>> Yong Zhi (3):
>>    ASoC: Intel: Headset button support in broxton machine driver
>>    ASoC: Intel: Add Geminilake Dialog Maxim machine driver
>>    ASoC: Intel: glk: Add DAI links for Multi-Playback
>>
>>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 101 +++++++++++++++++++++++---
>>   1 file changed, 89 insertions(+), 12 deletions(-)
>
> All 3 patches
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
Yong Zhi, looks like this ack never made it outside of my draft folder 
on Jan 23 and now unfortunately the patches don't apply cleanly any 
longer. Would you mind sending a v4? Sorry for the delayed response and 
generating extra work :-(

Thanks!

-Pierre
