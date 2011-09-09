From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: Player Thread is not woken after period elapsed
Date: Fri, 9 Sep 2011 18:12:03 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507C4317651@bgsmsx502.gar.corp.intel.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
	<20110905105253.2787b91f@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C420F15C@bgsmsx502.gar.corp.intel.com>
	<20110905112225.72b46ac9@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C4275D58@bgsmsx502.gar.corp.intel.com>
	<20110906200614.57a99d3d@infradead.org>
	<3CA6C6D9F70D314CA34352990B57DA1507C42767FA@bgsmsx502.gar.corp.intel.com>
	<20110908021327.GA8890@zhy> <20110908072948.GB11124@zhy>
	<3CA6C6D9F70D314CA34352990B57DA1507C42C3CA5@bgsmsx502.gar.corp.intel.com>
	<20110909060725.GA21124@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 37B22250E4
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 14:42:10 +0200 (CEST)
In-Reply-To: <20110909060725.GA21124@zhy>
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

> > > > > Further investigation of this issue shows that the thread is in
> > > > > running state
> 
> Hmm, how do you detect it?
> 
> > > and it is not scheduled. I am not sure how I will go about debugging this
> issue.
> > > Any pointer would help.
> 
> Could 'cat /proc/sched_debug' give some useful info?
Tried. It did not help.
> 
> And BTW, have you tried CONFIG_DETECT_SOFTLOCKUP = y?
> 
It is already set. 
