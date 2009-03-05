From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] pxa-ssp: don't touch ssp
	registers	when stream is running
Date: Thu, 5 Mar 2009 11:23:37 +0100
Message-ID: <20090305102337.GB28448@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<20090304203350.GB10731@sirena.org.uk>
	<20090304203911.GA18917@buzzloop.caiaq.de>
	<20090304204222.GC10731@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D56A210381B
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:23:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304204222.GC10731@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 08:42:22PM +0000, Mark Brown wrote:
> On Wed, Mar 04, 2009 at 09:39:11PM +0100, Daniel Mack wrote:
> > On Wed, Mar 04, 2009 at 08:33:52PM +0000, Mark Brown wrote:
> 
> > > I'd expect an error to be reported here - if we needed to change the
> > > settings and can't things could go wrong.  Ideally it'd check to see if
> > > the DAI format was being changed and only error if it was.
> 
> > In my tests, pxa_ssp_set_dai_fmt() was simply called twice, once for the
> > input, once for the ouput. Hence I believed a silent exit in such a case
> 
> That'll be because you weren't changing the DAI format - hence my
> comment about only erroring if the format is changed.

Ok, that makes sense. We should probably do something silimar in
set_hw_params() were we also currently exit silently in case of running
streams.

I'll post a new set soon when we sorted out more things on the other
patches.

Daniel
