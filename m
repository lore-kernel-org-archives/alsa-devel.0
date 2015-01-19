From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Add delay for output disable
Date: Mon, 19 Jan 2015 16:58:50 +0000
Message-ID: <20150119165850.GY14516@opensource.wolfsonmicro.com>
References: <1421682586-6303-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150119162432.GF2809@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 753A12610B7
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 17:58:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150119162432.GF2809@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2015 at 04:24:32PM +0000, Mark Brown wrote:
> On Mon, Jan 19, 2015 at 03:49:46PM +0000, Charles Keepax wrote:
> 
> > +	case SND_SOC_DAPM_POST_PMD:
> > +		switch (w->shift) {
> > +		case ARIZONA_OUT1L_ENA_SHIFT:
> > +		case ARIZONA_OUT1R_ENA_SHIFT:
> > +		case ARIZONA_OUT2L_ENA_SHIFT:
> > +		case ARIZONA_OUT2R_ENA_SHIFT:
> > +		case ARIZONA_OUT3L_ENA_SHIFT:
> > +		case ARIZONA_OUT3R_ENA_SHIFT:
> > +			udelay(750);
> > +			break;
> 
> That's a really quite long udelay() especially given that as the code is
> written it's going to be cumalative over all the outputs being torn down
> so typically will be 1.5ms for headphones (not sure if that's the
> intention or not).  msleep() would be more friendly than udelay() and
> it'd also be good to arrange to coalesce the delays.  Perhaps set a flag
> in _PRE_PMD and check if a delay is needed in the clock teardown?  Or
> better yet record a timestamp and then figure out if a delay is needed
> when tearing down the clock though that is probably overengineering.

Similar to the power up the delay needs to be cumulative as the
write sequences will queue themselves up if the last one is still
running when the next one is started. It is fairly long for a
udelay I will replace with an msleep(1) instead.

Thanks,
Charles
