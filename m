From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC: Intel: Skylake: Critical IPC
 fixes and flow adjustments
Date: Tue, 25 Jun 2019 08:10:36 -0500
Message-ID: <d04c8288-9f53-c921-2cab-120f78548e85@linux.intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
 <20190625105335.GO5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72238F8071F
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 15:10:40 +0200 (CEST)
In-Reply-To: <20190625105335.GO5316@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, cezary.rojewski@intel.com
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 6/25/19 5:53 AM, Mark Brown wrote:
> On Thu, Jun 13, 2019 at 09:04:29PM +0200, cezary.rojewski@intel.com wrote:
>> From: Cezary Rojewski <cezary.rojewski@intel.com>
>>
>> This set of changes contains critical IPC fixes:
>> - ASoC: Intel: Skylake: Read HIPCT extension before clearing DONE bit
>> - ASoC: Intel: Fix race condition in IPC rx list
> 
> Pierre, any thoughts on this series?

This series I looked at in detail and it was the basis for the recent 
SOF cleanup on IPC. There are still some improvements being debated on 
when exactly the IPC interrupts need to be unmasked - Guennadi suggested 
the interrupt need to be re-enabled at the beginning of the interrupt 
thread to avoid missing events - but this can come as bullet-proof 
hardening patches later for both SOF and Skylake. For now this is a good 
first pass, feel free to take the following tag for the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
