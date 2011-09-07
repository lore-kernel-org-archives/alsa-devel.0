From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: Player Thread is not woken after period elapsed
Date: Wed, 7 Sep 2011 17:32:10 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507C42767FA@bgsmsx502.gar.corp.intel.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
	<20110905105253.2787b91f@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C420F15C@bgsmsx502.gar.corp.intel.com>
	<20110905112225.72b46ac9@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C4275D58@bgsmsx502.gar.corp.intel.com>
	<20110906200614.57a99d3d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D70524862
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 14:03:32 +0200 (CEST)
In-Reply-To: <20110906200614.57a99d3d@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> 
> > >
> > > Please always test bugs like this with a recent kernel. 2.6.35 is
> > > pretty much 6 versions (and 18 months) behind and at that point you
> > > really have to test with something newer first before asking others
> > > to help you and spend their time on your problem.
> > >
> > Unfortunately, I am stuck with that version as the product that I work
> > on is on that version.
> 
> and that is everyone elses problem ... how?
> 
> if you can't be bothered to try at least a recent kernel, why would anyone else
> be bothered to help you on their own time?????
> 
I completely agree with you. Sorry for the inconvenience. But I have no choice. 
Further investigation of this issue shows that the thread is in running state and it is not scheduled. I am not sure how I will go about debugging this issue. Any pointer would help. 
> 
> --
