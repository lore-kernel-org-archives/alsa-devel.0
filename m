From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ASoC: sun4i-i2s: remove some dead code
Date: Tue, 7 Feb 2017 16:50:08 +0300
Message-ID: <20170207135008.GL11103@mwanda>
References: <20170207131934.GD28207@mwanda>
 <20170207134215.f47cufvs7tngrabk@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 83313267040
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:50:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170207134215.f47cufvs7tngrabk@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 07, 2017 at 02:42:15PM +0100, Maxime Ripard wrote:
> > -	if (!IS_ERR(i2s->rst)) {
> > -		ret = reset_control_deassert(i2s->rst);
> > -		if (ret) {
> > -			dev_err(&pdev->dev,
> > -				"Failed to deassert the reset control\n");
> > -			return -EINVAL;
> > -		}
> > +	ret = reset_control_deassert(i2s->rst);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to deassert the reset control\n");
> > +		return -EINVAL;
> 
> In the case where has_reset is false, rst is NULL and will trigger a
> WARN_ON in reset_control_deassert.
> 

No it won't.  reset_control_deassert(NULL) just returns success
immediately.

> The proper fix would be to move it in the previous if block, or to
> change the IS_ERR check for a NULL check.

We could move it as a clean up but the current code works.  Checking for
NULL is wrong.

regards,
dan carpenter
