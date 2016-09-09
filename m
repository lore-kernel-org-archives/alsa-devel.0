From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: remove status, it is shadowing
 status of a higher scope
Date: Fri, 9 Sep 2016 18:09:29 +0100
Message-ID: <b188eb88-7d83-f173-56ab-69d508611214@canonical.com>
References: <20160909090929.27845-1-colin.king@canonical.com>
 <2232d5d3-2a14-aa13-b41c-ae90fe530357@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2232d5d3-2a14-aa13-b41c-ae90fe530357@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Sachin Mokashi <sachinx.mokashi@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/09/16 18:04, Pierre-Louis Bossart wrote:
> On 9/9/16 2:09 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The second declaration of status is shadowing the status of a higher
>> scope.  This uninitialized status results in garbage being returned
>> by the !x86_match_cpu(cpu_ids) || !iosf_mbi_available() return exit
>> path.  Fix this by removing the extraneous second declaration of
>> status.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Gah... thanks for correcting this, not sure how I missed it, was there a
> compiler warning?

static analysis tools, this time CoverityScan

> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
>> ---
>>  sound/soc/intel/atom/sst/sst_acpi.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c
>> b/sound/soc/intel/atom/sst/sst_acpi.c
>> index 773acfb..4c14215 100644
>> --- a/sound/soc/intel/atom/sst/sst_acpi.c
>> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
>> @@ -249,7 +249,6 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
>>              { X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
>>              {}
>>          };
>> -        int status;
>>          u32 bios_status;
>>
>>          if (!x86_match_cpu(cpu_ids) || !iosf_mbi_available()) {
>>
> 
