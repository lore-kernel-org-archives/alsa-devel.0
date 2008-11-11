From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [RFC][PATCH] pxa2xx-ac97: switch AC unit to
 correct state before	probing
Date: Tue, 11 Nov 2008 14:51:47 +0300
Message-ID: <491971D3.8080604@gmail.com>
References: <20081110191124.GA2140@doriath.ww600.siemens.net>
	<20081111104739.GB7019@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id C891E1037FA
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:52:43 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1780678nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 03:52:43 -0800 (PST)
In-Reply-To: <20081111104739.GB7019@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Nov 10, 2008 at 10:11:24PM +0300, Dmitry Baryshkov wrote:
> 
>> AC97 irq, I see a unending storm of irq requests. I've come with the
>> following patch (against 2.6.27, if the idea is OK, I'll rebase against
>> 2.6.28-rc).
> 
> That's going to cause the pxa25x to use the full timeout for the reset
> since it uses the interrupt to detect completion.  This should just
> introduce a delay (which we shouldn't do) and may break something.  I'd
> expect that simply switching pxa25x to polling GSR for completion like
> everything else does would deal with it but testing would be nice if
> anyone has a board...

I'll check on tosa (pxa255). However I didn't notice any additional 
delay during startup.

> 
> Otherwise it looks OK - we're not using the interrupt for anything else
> until after we've reset things so it's a sensible solution.


-- 
With best wishes
Dmitry
