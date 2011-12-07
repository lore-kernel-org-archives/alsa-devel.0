From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 7 Dec 2011 22:23:15 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCAD8476@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
	<1322973076.30390.14.camel@vkoul-udesk3>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
	<4ede780f.890bb50a.54a3.ffffcc4dSMTPIN_ADDED@mx.google.com>
	<CAKg5Tpo6LgirbVVe9ZXNGN-xq7FTZvgAXNQ2HnXh=gwQHjn_Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DA20F103810
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 17:53:24 +0100 (CET)
In-Reply-To: <CAKg5Tpo6LgirbVVe9ZXNGN-xq7FTZvgAXNQ2HnXh=gwQHjn_Pw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

 
> > Even the thread which actually writes the data to ring buffer may not
> > have the idea of frames So the start threshold does not require to be
> > on frame boundaries. It is just to avoid START when the buffer is
> > written with the data. If the write gives more data than the ring
> > buffer, write will not unblock and the user space application may not
> > be able to call START.
> > This will be an issue if you go for non-blocking implementation.
> > Otherwise, START should be called in another thread than the thread
> > which writes the data.
> 
> I did not understand a single line of this comment.
> Why is this start threshold needed again and how would its value be defined for
> compressed data?

I will try to explain it with more details. 

Consider the case of blocking "write" call:

If the user space app writes the buffer with the content of size greater than the 
ring buffer size, write call will block. How do you expect the user space to invoke START ioctl?
I assume the write call will block until it writes the complete content into the buffer. 

To avoid this behavior, the app has to query only the empty space and write only that much data.
Then it should call START. 
