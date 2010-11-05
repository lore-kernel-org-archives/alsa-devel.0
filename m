From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Fri, 5 Nov 2010 11:25:22 -0400
Message-ID: <20101105152521.GA24390@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104183140.GD6088@opensource.wolfsonmicro.com>
	<1288949677.8256.14.camel@dplaptop>
	<20101105133143.GH13709@opensource.wolfsonmicro.com>
	<1288965591.8256.40.camel@dplaptop>
	<20101105140757.GC15977@opensource.wolfsonmicro.com>
	<1288966320.8256.42.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB120103954
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 16:25:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288966320.8256.42.camel@dplaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 02:12:00PM +0000, Dimitris Papastamos wrote:
> On Fri, 2010-11-05 at 10:07 -0400, Mark Brown wrote:

> > They could be setting these up later, or otherwise initialising.  It's
> > likely that nobody is but it's ringing an alarm bell that we need to
> > audit in case there's something that's going to bite us later on.

> Yup sure, it'd be wise to audit the codecs for any invalid use of the
> caching API.

Thanks.
