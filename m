From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: Player Thread is not woken after period elapsed
Date: Thu, 8 Sep 2011 15:15:38 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507C42C3CA5@bgsmsx502.gar.corp.intel.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
	<20110905105253.2787b91f@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C420F15C@bgsmsx502.gar.corp.intel.com>
	<20110905112225.72b46ac9@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C4275D58@bgsmsx502.gar.corp.intel.com>
	<20110906200614.57a99d3d@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C42767FA@bgsmsx502.gar.corp.intel.com>
	<20110908021327.GA8890@zhy> <20110908072948.GB11124@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 53B3124397
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 11:45:48 +0200 (CEST)
In-Reply-To: <20110908072948.GB11124@zhy>
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
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: alsa-devel@alsa-project.org

> > > Further investigation of this issue shows that the thread is in running state
> and it is not scheduled. I am not sure how I will go about debugging this issue.
> Any pointer would help.
> >
> > Could you confirm if [commit f26f9af Sched: fix skip_clock_update
> > optimization] residents in your kernel?
I applied this patch manually. I still see the issue.
> 
> And commit da7a735e51f9622eb3e1672594d4a41da01d7e4f
> http://marc.info/?l=linux-kernel&m=129527509622696&w=2
This is already applied.
