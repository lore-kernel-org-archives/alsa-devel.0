From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22
	audio codec
Date: Wed, 21 Jun 2017 21:22:47 +0800
Message-ID: <20170621132245.GD3372@dragon>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
 <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
 <20170620031131.GB4818@x250>
 <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D17B2668F0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 15:22:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170620143352.rjitvgkzh554pviq@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 20, 2017 at 03:33:52PM +0100, Mark Brown wrote:
> On Tue, Jun 20, 2017 at 11:11:32AM +0800, Shawn Guo wrote:
> > On Mon, Jun 19, 2017 at 05:16:06PM +0100, Mark Brown wrote:
> 
> > > If there's an external power amplifier this is a separate chip to this
> > > CODEC and should therefore be separately controlled and integrated as
> > > part of the machine integration.
> 
> > Yes, that should be the best.  But we do not have a particular machine
> > driver for our platform, and we are using simple-audio-card driver
> 
> You should be switching to the of-graph card now.

Thanks for the info.  Will do.

> > instead.  I'm not sure if it's generic enough to patch simple-audio-card
> > driver support this pa-gpios, so chose to fold this quick change in the
> > codec driver.
> 
> Having a separate amplifier is a completely normal thing, and no matter
> how unusual something is it's obviously not OK to hack one driver to
> support a completely different device.

Okay, I will drop it from codec driver, and try to support it in
audio-graph-card with separate patch later.

Shawn
