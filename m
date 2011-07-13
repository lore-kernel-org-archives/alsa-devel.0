From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
Date: Wed, 13 Jul 2011 11:09:03 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDB17@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310528167-25035-1-git-send-email-b29396@freescale.com>
	<20110713091314.GC1928@pengutronix.de>
	<20110713095629.GE1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110713095629.GE1928@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Wednesday, July 13, 2011 5:56 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; u.kleine-koenig@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
> 
> On Wed, Jul 13, 2011 at 11:13:14AM +0200, Wolfram Sang wrote:
> > On Wed, Jul 13, 2011 at 11:36:07AM +0800, Dong Aisheng wrote:
> > > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  arch/arm/mach-mxs/mach-mx28evk.c |   16 ++++++++++++++++
> > >  1 files changed, 16 insertions(+), 0 deletions(-)
> >
> > Also needs in Kconfig:
> >
> > +       select MXS_HAVE_PLATFORM_MXS_I2C
> 
> #include <linux/i2c.h> for i2c_register_board_info() might be good, too...
Will add them all.
Thanks.

Regards
Dong Aisheng
