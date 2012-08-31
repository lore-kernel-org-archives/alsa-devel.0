From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 0/3] introduce device_buffer
Date: Fri, 31 Aug 2012 20:23:18 +0530
Message-ID: <1346424798.1895.92.camel@vkoul-udesk3>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
 <504094DC.1060003@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AE1A265B95
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 16:53:31 +0200 (CEST)
In-Reply-To: <504094DC.1060003@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.de, vkoul@infradead.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-08-31 at 12:41 +0200, Jaroslav Kysela wrote:
> Date 31.8.2012 03:14, Vinod Koul wrote:
> > Old wine in a new bottle with added flavour now.
> > Based on our discussions in LPC, now we will report the combined delay value as
> > sum of the buffering done in driver and hardware. This is used to report delay
> 
> 
> > Additionally we tell pcm what is buffer in device/driver, this is used to check
> > for error calulcations
> 
> I'm afraid, but this won't work for the mmaped appl_ptr / hw_ptr,
> because the checks are done outside the kernel - in alsa-lib. I believe
> that this API should be enhanced, too. But the question is, how to pass
> two values (hwptr, device_buffer) atomically to the user space without
> locks for x86.
Yes for mmap case, tis needs to be done in lib and that can't be done
without ABI/API changes??
Is there a reserved field we can perhaps use for this

-- 
~Vinod
