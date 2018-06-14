From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v2 4/6] soundwire: Handle multiple master
 instances in a stream
Date: Thu, 14 Jun 2018 08:42:43 +0530
Message-ID: <20180614031242.GN3116@snc-desk>
References: <1528800824-696-1-git-send-email-shreyas.nc@intel.com>
 <1528800824-696-5-git-send-email-shreyas.nc@intel.com>
 <d6df99eb-e48b-7354-849d-cde43e33b504@linux.intel.com>
 <20180613055441.GA1127@buildpc-HP-Z230>
 <e34a35a8-9c2d-b254-65d2-012d57d5f528@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 406592675CA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 05:14:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e34a35a8-9c2d-b254-65d2-012d57d5f528@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

> >>>+
> >>>+		/* Bank switch */
> >>>+		ret = sdw_bank_switch(bus);
> >>>  		if (ret < 0) {
> >>>-			dev_err(bus->dev, "Pre bank switch op failed: %d", ret);
> >>>+			dev_err(bus->dev, "Bank switch failed: %d", ret);
> >>>  			return ret;
> >>>  		}
> >>You probably want to add a comment that in multi-link operation the actual
> >>bank_switch happens later and is done in a synchronized manner. This is lost
> >>if you just move code around and move the bank_switch into a loop.
> >>
> >>I am actually no longer clear just looking at this code on when the
> >>bank_switch happens (i know we've discussed this before but I am trying to
> >>find out just based on this v2 instead of projecting how I think it should
> >>work):
> >>In Patch 6/6 it's pretty obvious that the bank switch happens when the
> >>SyncGO bit is set, but there is no comment or explanation on how we reach
> >>the intel_post_bank_switch() routine once for all masters handling a stream
> >>when everything is based on loops. Clearly the intel_pre_bank_switch is
> >>called multiple times (once per master), I guess I am missing what the
> >>trigger is for the intel_post_bank_switch() routine to be invoked?
> >>
> >
> >Hi Pierre,
> >
> >To answer your last question, do_bank_switch is where we perform all the
> >bank switch operations.
> >
> >In first loop for Master(s) involved in stream, ops->pre_bank_switch and
> >bank_switch is performed. In 2nd loop for Master(s) involved in stream,
> >ops->post_bank_switch and wait for bank switch is performed.
> >
> >Assuming a stream with Master 1 and Master 2, the go_sync bit will be
> >set in Master 1 intel_post_bank_switch call which will trigger bank
> >switch for both the Master's. The Master 2 intel_post_bank_switch call
> >will just return as it will won't see CMDSYNC bit set for any Master(s).
> 
> Makes sense, thanks for taking the time to provide the details I didn't
> remember.
> Sreyas, if you could add a bit of information on this it'd be a good thing -
> specifically the expectation is that the bank switch is triggered by the
> first master in the master_list loop while others just return without doing
> anything.
> 

Sure, makes sense. I will add these details in the relevant patch.

--Shreyas

-- 
