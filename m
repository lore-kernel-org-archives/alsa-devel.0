From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3 0/3] introduce device_buffer
Date: Fri, 31 Aug 2012 12:41:32 +0200
Message-ID: <504094DC.1060003@perex.cz>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4578E265DF7
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 12:41:33 +0200 (CEST)
In-Reply-To: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Date 31.8.2012 03:14, Vinod Koul wrote:
> Old wine in a new bottle with added flavour now.
> Based on our discussions in LPC, now we will report the combined delay value as
> sum of the buffering done in driver and hardware. This is used to report delay


> Additionally we tell pcm what is buffer in device/driver, this is used to check
> for error calulcations

I'm afraid, but this won't work for the mmaped appl_ptr / hw_ptr,
because the checks are done outside the kernel - in alsa-lib. I believe
that this API should be enhanced, too. But the question is, how to pass
two values (hwptr, device_buffer) atomically to the user space without
locks for x86.

					Jaroslav

> 
> Vinod Koul (3):
>   ALSA: pcm - introduce device_buffer
>   ASoC: add device_buffer in asoc
>   ASoC: mid-x86 - implement buffer query in sst_platform driver
> 
>  include/sound/pcm.h              |    1 +
>  include/sound/soc-dai.h          |    6 ++++++
>  include/sound/soc.h              |    6 ++++++
>  sound/core/pcm_lib.c             |   10 +++++++++-
>  sound/soc/mid-x86/sst_platform.c |   23 +++++++++++++++++++++++
>  sound/soc/mid-x86/sst_platform.h |    4 +++-
>  sound/soc/soc-pcm.c              |   13 ++++++++++++-
>  7 files changed, 60 insertions(+), 3 deletions(-)
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
