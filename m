From: John Keeping <john@metanate.com>
Subject: Re: [PATCH] ASoC: rockchip: i2s: fix playback after
	runtime resume
Date: Mon, 8 Jan 2018 15:59:06 +0000
Message-ID: <20180108155906.19fe98a2.john@metanate.com>
References: <20180108122301.18255-1-john@metanate.com>
 <20180108152641.GF11698@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B1FB52673AF
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 16:59:16 +0100 (CET)
In-Reply-To: <20180108152641.GF11698@sirena.org.uk>
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
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Jan 2018 15:26:41 +0000, Mark Brown wrote:

> On Mon, Jan 08, 2018 at 12:23:01PM +0000, John Keeping wrote:
> 
> > @@ -527,6 +531,7 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >  static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
> >  {
> >  	switch (reg) {
> > +	case I2S_RXDR:
> >  	default:
> >  		return false;
> >  	}  
> 
> This doesn't look right?

No, it's not, it should be "return true;" for I2S_RXDR.
