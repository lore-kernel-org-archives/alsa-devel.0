From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Fri, 10 Apr 2009 11:22:41 +0100
Message-ID: <20090410102240.GA6882@sirena.org.uk>
References: <49DDFE1D.3090009@samsung.com>
	<20090409140654.GC18152@sirena.org.uk>
	<49DEA8FE.8010700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BA324412
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Apr 2009 12:22:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49DEA8FE.8010700@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 10, 2009 at 11:03:42AM +0900, Joonyoung Shim wrote:
> On 4/9/2009 11:06 PM, Mark Brown wrote:

> >> +	if (infreq != TWL4030_APLL_INFREQ_26000KHZ)
> >> +		return -EPERM;

> > It's probably worth a comment here telling users that they'll need to
> > call set_sysclk() in their init() function rather than hw_params() -
> > otherwise this might get called before the clock is set up.

> It seems better that i remove startup function and add set_sysclk function,
> and inform supporting only 26MHz system master clock through comment. 
> i think it is not important where set_sysclk() is called, the voice PCM
> interface needs just 26MHz system master clock.

It does feel right to have some sort of check for a valid sysclk so that
there's some software level documentation for the requirement since it's
easy to set up an ASoC driver without reading the datasheet for the part
so it's helpful if the driver can flag up broken configurations to them.

The reason for worrying about where set_sysclk() is called from is that
if you are going to have a check like that the user needs to call
set_sysclk() before the check is performed to ensure that the correct
configuration has been applied.
