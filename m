From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/2] Update Poodle to current ASoC API
Date: Thu, 24 Jul 2008 17:13:43 +0400
Message-ID: <20080724131343.GA4625@doriath.ww600.siemens.net>
References: <20080724125448.GA4695@doriath.ww600.siemens.net>
	<20080724131019.GA14962@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 37DC4103908
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 15:14:01 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1007293nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2008 06:14:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080724131019.GA14962@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.arm.linux.org.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 24, 2008 at 02:10:21PM +0100, Mark Brown wrote:
> On Thu, Jul 24, 2008 at 04:54:48PM +0400, Dmitry Baryshkov wrote:
> > Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  This should probably go into 2.6.27, if possible
> 
> I've queued this for Takashi, thanks (he's on holiday this week).  I
> had thought that at least the second hunk was already fixed but it seems
> not.

Actually the driver will still be broken w/o first patch. I hope that it
will be abe get in via Russell's tree.

> 
> Please CC all ALSA patches to alsa-devel@alsa-project.org.

This does collide with "don't cc lists if sending to LAKML" :)

-- 
With best wishes
Dmitry
