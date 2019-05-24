From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/6] ASoC: Intel: Skylake: move NHLT
 header to common directory
Date: Fri, 24 May 2019 08:11:29 -0500
Message-ID: <c6d3702b-4a1c-ba4f-5404-fac2563be293@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <20190523233951.31122-3-pierre-louis.bossart@linux.intel.com>
 <s5ho93se2ns.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0B15F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 15:11:33 +0200 (CEST)
In-Reply-To: <s5ho93se2ns.wl-tiwai@suse.de>
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



On 5/24/19 2:23 AM, Takashi Iwai wrote:
> On Fri, 24 May 2019 01:39:47 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Prepare move from NHLT code to common directory, starting with header.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/{skylake/skl-nhlt.h => common/intel-nhlt.h} | 0
> 
> 
> Since the header is included over ASoC, it should be rather into
> include/sound.

ok. should we use an hda-intel-nhlt name then?
