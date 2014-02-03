From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: compress: adding support for hardware dependent
 params
Date: Mon, 03 Feb 2014 08:25:31 -0600
Message-ID: <52EFA6DB.4030905@linux.intel.com>
References: <655481c83253b83c0c7b902829eabfa6.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 73903260845
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 15:25:44 +0100 (CET)
In-Reply-To: <655481c83253b83c0c7b902829eabfa6.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Banajit Goswami <bgoswami@codeaurora.org>, vinod.koul@linux.intel.com
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org


>
>   We have a requirement, where we need to set a number of hardware specific
> parameters for compressed offload use-cases, before starting a stream. As
> these parameters need to be set once for the entire session, we would
> like to explore the best way to set these additional parameters somewhere
> before calling trigger() function.

I think you need to provide more context here. The compressed API 
provides a fair amount of information on the parameters needed to handle 
the stream - maybe too much in most cases -, I don't really get the 
rationale for hardware-specific parameters needed specifically for 
compressed data that you wouldn't need for PCM.
I am also not clear on how we are going to agree on new hw_params that 
are hardware specific. Shouldn't this sort of requirement be handled 
through a control interface?
