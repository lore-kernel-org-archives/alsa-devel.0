From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of pr_warning to
 pr_warn
Date: Fri, 17 Feb 2017 15:57:52 -0800
Message-ID: <20170217235751.GA4125@Asurada-Nvidia>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170217234854.spi62waguwd7kpno@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Joe Perches <joe@perches.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 17, 2017 at 11:48:54PM +0000, Mark Brown wrote:
> On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > > To enable eventual removal of pr_warning
> > > 
> > > This makes pr_warn use consistent for sound/soc
> > > 
> > > Prior to this patch, there were 5 uses of pr_warning and
> > > 10 uses of pr_warn in sound/soc
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > For imx-audmux.c,
> 
> I don't have this patch, perhaps it got caught in a spam filter or
> perhaps it got deleted because as ever you're not using subject lines
> reflecting the style for the subsystem.

My bad that I didn't pay attention to the subject.

Joe, please fix it in v2. Thanks.

ASoC: Convert remaining uses of pr_warning to pr_warn
