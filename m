From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Tue, 14 Feb 2012 15:34:15 +0800
Message-ID: <20120214073414.GB3276@b20223-02.ap.freescale.net>
References: <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
 <20120214013506.GA3276@b20223-02.ap.freescale.net>
 <20120214060627.GB13456@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120214060627.GB13456@opensource.wolfsonmicro.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Richard Zhao <richard.zhao@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, kernel@pengutronix.de, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, eric.miao@linaro.org, eric@eukrea.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 13, 2012 at 10:06:28PM -0800, Mark Brown wrote:
> On Tue, Feb 14, 2012 at 09:35:07AM +0800, Richard Zhao wrote:
> > On Sun, Feb 05, 2012 at 12:50:15PM +0800, Richard Zhao wrote:
> 
> > > no, it is asoc machine driver to have machine specific code. 
> > > the machine driver do not correspond to any hw device, which cause hard
> > > to bind dt or create platform device.
> 
> > I'll have to keep audmux driver in arch/, till ASOC machine driver
> > has a way to get platfrom parameters.
> 
> Machine drivers can easily get platform data, they're just regular
> drivers of whatever type so can get platform data in the same way that
> any other driver for their bus can.
Machine drivers don't correspond to any hw devices. If we create a
virtual platform device, it'll be hard for DT binding.

Thanks
Richard

