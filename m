From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Implement TDM support for
	Arizona	devices
Date: Wed, 4 Jun 2014 09:08:08 +0100
Message-ID: <20140604080808.GG11951@opensource.wolfsonmicro.com>
References: <1401822370-5324-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140603220607.GD2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7EFC261A8C
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 10:08:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140603220607.GD2520@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 03, 2014 at 11:06:07PM +0100, Mark Brown wrote:
> On Tue, Jun 03, 2014 at 08:06:10PM +0100, Charles Keepax wrote:
> 
> > +	if (tdm_width && wl != tdm_width)
> > +		arizona_aif_warn(dai, "Word length not equal to TDM width\n");
> > +
> 
> Is it a problem to have say 16 bit words in a 32 bit TDM slot?  One of
> the reasons this stuff sometimes gets used is to help out the other
> connected device if it's having trouble configuring the "natural" clock
> rates.  Ignoring LSBs shouldn't be an issue.

A good point I will respin and take this out.

Thanks,
Charles
