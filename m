From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor
 calculation
Date: Tue, 24 Feb 2015 01:13:22 -0800
Message-ID: <20150224091321.GA3064@Asurada-CZ80>
References: <1423993031-29474-1-git-send-email-nicoleotsuka@gmail.com>
 <20150224082642.GZ6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224082642.GZ6236@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, timur@tabi.org, mpa@pengutronix.de, shengjiu.wang@freescale.com, zidan.wang@freescale.com, scerveau@voxtok.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 24, 2015 at 05:26:42PM +0900, Mark Brown wrote:
> On Sun, Feb 15, 2015 at 01:37:11AM -0800, Nicolin Chen wrote:
> > According to i.MX6 Series Reference Manual, the formula to calculate
> > the sys clock is
> 
> This doesn't apply against current code, pleae check and resend.

That's strange...I downloaded it from Patchwork and tried to apply
it on the latest for-next. It doesn't give me any error...

And I git-formated a new one but it doesn't look so different from
the one in the maillist...

Thank you
Nicolin
