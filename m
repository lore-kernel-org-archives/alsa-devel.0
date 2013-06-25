From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 2/3] ARM: dts: mx28: Provide a codec clock
Date: Tue, 25 Jun 2013 10:27:59 -0700
Message-ID: <20130625172759.23972.34839@quantum>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
 <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
 <20130625142257.GE12178@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130625142257.GE12178@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: marex@denx.de, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Quoting Shawn Guo (2013-06-25 07:22:58)
> On Tue, Jun 25, 2013 at 11:00:00AM -0300, Fabio Estevam wrote:
> > Since commit 9e13f345887 (ASoC: sgtl5000: Let the codec acquire its clock) it is 
> > necessary to pass a codec clock to the sgtl5000 driver.
> > 
> > Since the saif mclk cannot be passed as a real clock within the clock framework,
> > let's pass a dummy one to the codec driver.
> > 
> Why can not saif driver register the mclk to clock framework?

There are a growing number of drivers which define their own clocks. One
example can be found in drivers/media/platform/omap3isp/isp.c.

Regards,
Mike

> 
> Shawn
> 
> > The mxs-saif driver will activate the codec clock.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
