From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 4 Oct 2010 10:04:24 +0100
Message-ID: <20101004100424.4e5cf40c@linux.intel.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 8373F243E0
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 11:54:02 +0200 (CEST)
In-Reply-To: <20101003201943.GA31764@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> IIRC at least one version had a split where the ALSA integration stuff
> was separated out from the underlying DSP interface code - that was
> pretty helpful since it helps focus on the ALSA specifics.

Yes but that split is no longer there once the clean up patches sit on
top because they weren't put together as separate bits. This is exactly
the sort of reason I want to get it in staging.


> > Agreed, although gstreamer is pretty good at that it would save
> > work if it can be partly generic. It's not trivial however because
> > the offload
> 
> Plus the fact that not everyone is using gstreamer at the application
> level :/
> 
> > interface with suitable firmware loaded does things other than PCM
> > and you have very firmware specific interfaces for configuring
> > those.
> 
> We ought to be able to come up with something for the core streaming
> stuff, though.  Like I say, it's just a nice to have though.

I would have thought PCM at least was also going to have some kind of
common structure.

> I do have some nervousness about the concept of staging for embedded
> stuff since I worry that inclusion in staging can send the wrong
> message to vendors but that's a completely separate issue to this
> driver.

Noted. But I'll point you at the SEP driver which did get bogged down
for ages for reasons I can't really go into publically, and we
therefore pulled out of staging.

Alan
