From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: kirkwood: cleanup the external clock probe
Date: Mon, 21 Oct 2013 09:52:00 +0100
Message-ID: <20131021085200.GW25034@n2100.arm.linux.org.uk>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
 <20131021102834.768c0887@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131021102834.768c0887@armhf>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 21, 2013 at 10:28:34AM +0200, Jean-Francois Moine wrote:
> On Mon, 21 Oct 2013 09:06:57 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Mon, Oct 21, 2013 at 09:46:13AM +0200, Jean-Francois Moine wrote:
> > > This patch checks the return value of the clk_prepare_enable of the
> > > external clock and removes the test about a same internal and external
> > > clock which would quite never occur and won't work in most cases
> > > it would occur.
> > 
> > NAK.  It can occur.
> 
> In which case? And, what would be the right treatment?

        priv->clk = devm_clk_get(&pdev->dev, NULL);
        priv->extclk = devm_clk_get(&pdev->dev, "extclk");

Supplying the first clock to this driver without a separate "extclk"
via clkdev will return it as the second clock.

Again, NAK.  Your change is against the principles of the clk API.
