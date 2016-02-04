From: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Subject: Re: [PATCH] ASoC: adau17x1: Cache writes when core
	clock is disabled
Date: Thu, 4 Feb 2016 20:01:30 +0100
Message-ID: <20160204190129.GA32441@lnxandire1.se.axis.com>
References: <1454594719-17270-1-git-send-email-andire@axis.com>
 <56B388DC.40601@metafoo.de> <56B38938.40000@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E4272619D0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 20:01:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56B38938.40000@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andreas =?iso-8859-1?Q?Irest=E5l?= <andire@axis.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 04, 2016 at 06:24:08PM +0100, Lars-Peter Clausen wrote:
> On 02/04/2016 06:22 PM, Lars-Peter Clausen wrote:
> [...]
> >> +	/* Enable cache only mode as we could miss writes before bias level
> >> +	 * reaches standby and the core clock is enabled */
> >> +	regcache_cache_only(regmap, true);
> >> +
> > 
> > There are a few register writes before this where the hardware configuration
> > is setup. When I look at my test setup those writes seem to go through, even
> > though they shouldn't according to what you say (and to what is written in
> > the datasheet).
> > 
> > On the other hand I've never seen the issue you are having either and I've
> > tested both master and slave configuration of the device. Maybe something
> > changed in the silicon in newer revisions of the device. Can you take a look
> > whether the hardware configuration is correctly applied for you?
> 
> Ah, no, ignore that. Those writes happen later on.
> 

The whole thing depends on what driver you are using. We had our own
board drivers before moving to DT, where we would call set_dai_fmt in
hw_params, so the register would get written again before we wanted to
do something useful anyway. The simple-card driver only set the dai format
at probing time and never again, so that's why we started to notice this
issue.

I posted a set of patches a few days ago which added DT support and
fixed minor things in adau17x1, but I realized I was clumsy just sending
it to the alsa-devel list and not including DT maintainers or any
maintainers at all. Would you have a look at it, or do you want me to
resubmit the patches with the correct recipents?

/Andreas
