From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 3/6] ASoC: Intel: common: move parts of
 NHLT code to new module
Date: Fri, 24 May 2019 08:16:05 -0500
Message-ID: <ece1c28e-183e-71b0-22cf-148047ae23c0@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <20190523233951.31122-4-pierre-louis.bossart@linux.intel.com>
 <s5hmujce18j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1C41F806F7
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 15:17:12 +0200 (CEST)
In-Reply-To: <s5hmujce18j.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org



On 5/24/19 2:54 AM, Takashi Iwai wrote:
> On Fri, 24 May 2019 01:39:48 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Move parts of the code outside of the Skylake driver to help detect
>> the presence of DMICs (which are not supported by the HDaudio legacy
>> driver).
>>
>> No functionality change, only indentation and checkpatch fixes, and making sure that the code compiles without ACPI
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> This is no ASoC-specific code, which will be called from the legacy
> HDA driver, too.  So better to drop SOC_ prefix.

ok.
I also thought about the location of the code, I am not sure this works 
if SND_SOC is not selected.

If SND_SOC is not selected, there is also no conflict with another 
driver so we may want to bypass this code. Or use it, flag that the 
config will prevent capture from working but continue the probe so that 
the playback works at least.
