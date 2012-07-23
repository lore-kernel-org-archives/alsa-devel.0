From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 14:51:48 -0500
Message-ID: <500DAB54.20705@linux.intel.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B795260317
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 21:51:47 +0200 (CEST)
In-Reply-To: <20120723104720.GK4435@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/2012 5:47 AM, Mark Brown wrote:
> I'm having a hard time relating this to what I was saying.  The point
> here is that if the device keeps marching on consuming data (as most
> cyclic DMAs would) then there's still going to be an underrun even if
> there's a buffer that causes a delay in the user hearing it
Not necessarily. The DMA between system memory and DSP buffers need not 
work at a rate linked to the serial bit clock, they can be much faster, 
and actually they should to help put the system in a low power state 
rather than reading continuously from memory... what Vinod is trying to 
explain is that due to the bursty nature of data transfers inside the 
soc, we need to modify how the accounting is done.
