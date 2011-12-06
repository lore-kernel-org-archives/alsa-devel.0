From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Tue, 6 Dec 2011 14:15:44 -0600
Message-ID: <25327.3937771612$1323202578@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>	<1322973076.30390.14.camel@vkoul-udesk3>	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>	<001501ccb361$3af49990$b0ddccb0$@bossart@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id AD341103BD4
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 21:16:07 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7DAC@bgsmsx502.gar.corp.intel.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>, 'Vinod Koul' <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> Even the thread which actually writes the data to ring buffer may not
> have the idea of frames
> So the start threshold does not require to be on frame boundaries. It
> is just to avoid START when the buffer is written with the data. If 
> the write gives more data than the ring buffer, write will not unblock 
> and the user space application may not be able to call START.
> This will be an issue if you go for non-blocking implementation.
> Otherwise, START should be called in another thread than the thread 
> which writes the data.

I did not understand a single line of this comment. 
Why is this start threshold needed again and how would its value be defined
for compressed data?
-Pierre
