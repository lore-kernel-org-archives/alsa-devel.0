From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: Applied "ASoC: samsung: s3c2412: Handle return value of
 clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 18:13:18 +0200
Message-ID: <20170726161318.GA4093@kozik-book>
References: <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
 <E1daN7g-0003Ze-AF@debutante>
 <20170726154642.GB2577@kozik-book>
 <20170726160700.tffy72uwhw4hilhw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726160700.tffy72uwhw4hilhw@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, perex@perex.cz, tiwai@suse.com, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 26, 2017 at 05:07:00PM +0100, Mark Brown wrote:
> On Wed, Jul 26, 2017 at 05:46:42PM +0200, Krzysztof Kozlowski wrote:
> 
> > Mark, this is the patch still discussed. It does not handle the error
> > correctly. I think it should be dropped.
> 
> Ugh, is that the same patch?  Sorry, got lost in the big series.  Now
> I've applied it I'd rather do incremental updates to it if possible but
> let's see if that can be done promptly...

Fixing this is not that critical because error path of s3c2412_i2s_probe()
already did not clean up what was needed. So merely we are duplicating
same wrong pattern.

I can prepare an incremental fix tomorrow or the day after, so, Arvind,
if you can do it faster, please go ahead.

Best regards,
Krzysztof
