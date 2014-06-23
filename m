From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v2] mfd: arizona: Export function to
	control	subsystem DVFS
Date: Mon, 23 Jun 2014 16:38:52 +0100
Message-ID: <20140623153852.GB23517@opensource.wolfsonmicro.com>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403275273-22713-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140621204549.GA24291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE9A02619DD
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 17:38:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140621204549.GA24291@sirena.org.uk>
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

On Sat, Jun 21, 2014 at 09:45:49PM +0100, Mark Brown wrote:
> On Fri, Jun 20, 2014 at 03:41:10PM +0100, Charles Keepax wrote:
> 
> > +	int ret = 0;
> 
> > +			ret = regulator_set_voltage(arizona->dcvdd,
> > +						    1800000, 1800000);
> > +			if (ret != 0) {
> > +				dev_err(arizona->dev,
> > +					"Failed to raise dcvdd (%u)\n", ret);
> > +				goto err;
> > +			}
> 
> I'm really nitpicking here but the error code is a signed integer being
> printed for some reason with %u and while I'm at it DCVDD would normally
> be written in all caps for human consumption.

Yeah that should be fixed.

> 
> > +int arizona_dvfs_down(struct arizona *arizona, unsigned int flags)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&arizona->subsys_max_lock);
> > +
> > +	arizona->subsys_max_rq &= ~flags;
> 
> Is it worth checking to see if the request was asserted and logging a
> warning if it wasn't?  The lack of refcounting suggests that a bit of
> defensiveness might be in order.

I think it seems reasonable, I will add some code for this.

Thanks,
Charles
