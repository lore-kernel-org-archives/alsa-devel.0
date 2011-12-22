From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Thu, 22 Dec 2011 14:18:52 +0530
Message-ID: <1324543732.1641.10137.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hwr9pniqx.wl%tiwai@suse.de>
	<1324541990.1641.10133.camel@vkoul-udesk3>
	<s5hty4tnh8e.wl%tiwai@suse.de>
	<1324542706.1641.10135.camel@vkoul-udesk3>
	<s5hr4zxngg3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D50624430
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 09:48:57 +0100 (CET)
In-Reply-To: <s5hr4zxngg3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-22 at 09:44 +0100, Takashi Iwai wrote:
> 
> You can use WARN() or snd_BUG_ON().
But WARN or snd_BUG_ON will continue execution and....
So better log it and return error, right?
> 
> > Only question is in these scenarios this is core corruption so what
> > would be the apt error code to use?
> 
> Well, there is no standard definition.  Just use a sensible errno that
> will abort the user-space appropriately (i.e. not like EPIPE).  Even
> -EFAULT would be OK, I think.
I like EFAULT

-- 
~Vinod
