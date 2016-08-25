From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 03/13] ASoC: topology: ABI - Define DPCM
 trigger ordering for PCM
Date: Thu, 25 Aug 2016 16:35:33 +0800
Message-ID: <57BEADD5.1040307@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823174135.GA22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B37CF2667DC
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 10:32:11 +0200 (CEST)
In-Reply-To: <20160823174135.GA22076@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 08/24/2016 01:41 AM, Mark Brown wrote:
> On Fri, Aug 19, 2016 at 06:12:55PM +0800, mengdong.lin@linux.intel.com wrote:
>
>> Definition of dynamic PCM trigger ordering is exposed to uapi asoc.h,
>> and topology allows user space to define the trigger ordering for PCM
>> (FE links).
>
> This seems *incredibly* implementation specific.  Why wouldn't the
> driver for the thing implementing the topology be able to figure out the
> ordering here?  What's the use case?  What happens when we change away
> from DPCM?
>

I'll check if we can let driver figure out this ordering or use some 
more generic name.

We add this trigger ordering as driver developer request and we think 
it's decided by the firmware behavior. We hope firmware properties can 
be covered by topology.

Thanks
Mengdong
