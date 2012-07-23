From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 15:16:28 -0500
Message-ID: <500DB11C.1050007@linux.intel.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
 <500DAB54.20705@linux.intel.com> <20120723200512.GB25707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 004D3260320
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 22:16:27 +0200 (CEST)
In-Reply-To: <20120723200512.GB25707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> Don't drop CCs from replies.
Sorry.
>
>> Vinod is trying to explain is that due to the bursty nature of data
>> transfers inside the soc, we need to modify how the accounting is
>> done.
> Right, but this depends on the ability of the device to pause reading
> data when it reads up to the point where the application has written.
> This is a separate capability to any latency that's been added by the
> buffering, and most of the systems that have the buffering don't have
> this capability but instead either don't report the buffer or rely on
> the application being a full buffer ahead of the hardware.
>
>
We don't have such fancy hardware (and I don't think anyone has). This 
can happen even with simple IP that has an embedded SRAM and bursty 
DMA,  if the IP buffer amounts to the period size to avoid partial wakes 
or transfers, and the application cannot provide more than one period 
initially you get an underflow that isn't a true one.
-Pierre
