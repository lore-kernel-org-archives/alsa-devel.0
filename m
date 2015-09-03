From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Thu, 3 Sep 2015 14:36:24 -0700
Message-ID: <20150903213623.GA11313@kwestfie-linux.qualcomm.com>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr>
 <55E35169.3000703@bfs.de>
 <alpine.DEB.2.02.1508302152300.2062@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1508302152300.2062@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: walter harms <wharms@bfs.de>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 30, 2015 at 12:54:15PM -0700, Julia Lawall wrote:
> On Sun, 30 Aug 2015, walter harms wrote:
> > Am 30.08.2015 20:05, schrieb Julia Lawall:
> > >  		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
> > >  			dev_err(&pdev->dev,
> > >  				"%s() error getting mi2s-bit-clk: %ld\n",
> > > -				__func__,
> PTR_ERR(drvdata->mi2s_bit_clk[i]));
> > > +				__func__,
> > > +				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
> > >  			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
> > >  		}
> > >  	}
> > > 
> > 
> > just a note:
> > using a shorter name instead of drvdata->mi2s_bit_clk[dai_id] whould
> help to make the code
> > more readable (yes, the other code is alike). something like:
> > 
> > struct clk *tmp =  devm_clk_get(&pdev->dev,clk_name);
> 
> Where do you suggest to put this?
> 
> Maybe it would be reasonable to declare a variable struct clk *clk; at the
> 
> top of the function, and then use that as a temporary variable for all 
> three calls.
> 
> However, now I see that the first call, unlike the other two doesn't cause
> 
> a return from the function.
> 
>                 if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
>                         dev_warn(&pdev->dev,
>                                 "%s() error getting mi2s-osr-clk: %ld\n",
> 				__func__,
> 		                PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
>                 }
> 
> Is that intentional?

Yes, that was intentional as the presense of the OSR clock in the DT
node is optional.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
