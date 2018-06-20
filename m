From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: common: rename 'reef' to
 'sof' in ACPI matching table
Date: Wed, 20 Jun 2018 10:59:43 -0500
Message-ID: <f1690317-8d6e-7877-b813-3c324f92d311@linux.intel.com>
References: <20180619190037.8307-1-pierre-louis.bossart@linux.intel.com>
 <20180620111736.GD6242@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id D493E266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 17:59:47 +0200 (CEST)
In-Reply-To: <20180620111736.GD6242@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/20/18 6:17 AM, Mark Brown wrote:
> On Tue, Jun 19, 2018 at 02:00:37PM -0500, Pierre-Louis Bossart wrote:
> 
>> -	.sof_fw_filename = "intel/reef-byt.ri",
>> -	.sof_tplg_filename = "intel/reef-byt-rt5670.tplg",
>> +	.sof_fw_filename = "intel/sof-byt.ri",
>> +	.sof_tplg_filename = "intel/sof-byt-rt5670.tplg",
> 
> We're sure nobody is using this stuff in production yet?

Yes. The topology tools were changed back in April to remove all 
references to reef, same for the firmware code.

https://github.com/thesofproject/soft/commit/4f6d459586c22a8c9d946ee821ccf9c1ce7804c7

we will make sure the IPC and topology are tracked in backwards 
compatible ways once devices are released, it's on our TODO list to add 
checks for version numbers and always make sure the kernel update does 
not require changes to the firmware or filesystems.
