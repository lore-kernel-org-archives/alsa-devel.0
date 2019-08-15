From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC: SOF: rename SOUNDWIRE to ALH
Date: Thu, 15 Aug 2019 13:30:52 -0500
Message-ID: <607969d8-2377-9e6a-a980-e89d67443438@linux.intel.com>
References: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
 <20190815155032.29181-2-pierre-louis.bossart@linux.intel.com>
 <20190815170853.GC4841@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F8A1F8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 20:30:56 +0200 (CEST)
In-Reply-To: <20190815170853.GC4841@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/15/19 12:08 PM, Mark Brown wrote:
> On Thu, Aug 15, 2019 at 10:50:29AM -0500, Pierre-Louis Bossart wrote:
>> From: Bard liao <yung-chuan.liao@linux.intel.com>
>>
>> Rename SOUNDWIRE to ALH.
> 
> What's this patch based on, it doesn't seem to be something upstream?
> 
> Description: [1/4] ASoC: SOF: rename SOUNDWIRE to ALH
> Applying: ASoC: SOF: rename SOUNDWIRE to ALH
> error: sha1 information is lacking or useless (include/sound/sof/dai.h).
> error: could not build fake ancestor
> Patch failed at 0001 ASoC: SOF: rename SOUNDWIRE to ALH

ok so this is upstream but the patch will not apply if you didn't take 
Daniel's iMX patches, which change the same dai.h file in '[PATCH 3/3] 
ASoC: SOF: topology: Add dummy support for i.MX8 DAIs'

I'll resubmit this separately.
