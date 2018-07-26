From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 7/8] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Thu, 26 Jul 2018 10:36:08 -0500
Message-ID: <358b0fb8-7346-066d-62e9-fd210e80b2b3@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
 <20180725114745.GN3661@vkoul-mobl>
 <bdff9535-3443-41e3-5866-698253eb28bc@linux.intel.com>
 <20180725162914.GX3661@vkoul-mobl> <20180726145812.GG2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 9441826776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 17:36:12 +0200 (CEST)
In-Reply-To: <20180726145812.GG2414@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org



On 07/26/2018 09:58 AM, Mark Brown wrote:
> On Wed, Jul 25, 2018 at 09:59:14PM +0530, Vinod wrote:
>> On 25-07-18, 09:27, Pierre-Louis Bossart wrote:
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +/*
>>>>> + * Copyright(c) 2015-17 Intel Corporation.
>>>>> + */
>>>> same patch different style ;/
>>> ok. Checkpatch reports different things for SPDX but I'll align on the C++
>>> version.
>> Yeah we still have bunch of versions floating out. Only consensus seems
>> to be for SPDX line in C99 style. So pick one you like and be consistent
>> with it.
> Headers are a C comment as they might be included by non-C stuff.
Ah, makes sense. if that's alright I'll use the following style then.

.h files

/* SPDX-License-Identifier: GPL-2.0 */
/*
  * Copyright(c) 2015-17 Intel Corporation.
  */

.c files
// SPDX-License-Identifier: GPL-2.0
/*
  * Copyright(c) 2015-17 Intel Corporation.
  */
