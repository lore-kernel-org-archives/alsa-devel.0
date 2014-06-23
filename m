From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4 v2] ASoC: wm_adsp: Move DVFS control
	into codec	driver
Date: Mon, 23 Jun 2014 16:41:59 +0100
Message-ID: <20140623154159.GC23517@opensource.wolfsonmicro.com>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403275273-22713-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140621205037.GB24291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A842264EE5
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 17:42:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140621205037.GB24291@sirena.org.uk>
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

On Sat, Jun 21, 2014 at 09:50:37PM +0100, Mark Brown wrote:
> On Fri, Jun 20, 2014 at 03:41:11PM +0100, Charles Keepax wrote:
> 
> > +	case SND_SOC_DAPM_PRE_PMD:
> > +		ret = arizona_dvfs_down(arizona, ARIZONA_DVFS_ADSP1_RQ);
> > +		if (ret != 0)
> > +			dev_warn(codec->dev,
> > +				 "Failed to lower DVFS: %d\n", ret);
> > +		break;
> 
> I would expect this to be _POST_PMD since it happens...

It might be a little more logical that way.

> 
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return wm_adsp2_early_event(w, kcontrol, event);
> 
> ...before we even give the ADSP event a chance to run meaning the
> voltage will be ramped down prior to halting the DSP.  If there are any
> connected outputs still live this might result in audible issues as the
> device goes out of spec briefly prior to being halted and there is some
> remote chance that it could cause problems on next power up I guess (it
> did go out of spec after all).

Although this isn't actually an issue as this is the preloader
widget we added for the firmware, which is a dai_link widget so
the DSP will have been shutdown by the main widget before this is
ever called. That said _POST_PMD makes the intention much more
clear so worth changing too.

Thanks,
Charles
