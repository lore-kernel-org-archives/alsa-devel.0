From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Fri, 3 Feb 2012 21:27:14 +0800
Message-ID: <20120203132711.GA12915@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120202130901.GE9773@S2101-09.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: Richard Zhao <richard.zhao@linaro.org>, alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 02, 2012 at 09:09:03PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> > On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
...
> > >  Or we can simply
> > > make the it a audmux-self call with 3 parameters it needs retrieved
> > > from platform_data or device tree, so that machine driver does not
> > > even bother with the call.  Makes sense?
> > audux configuration may change after initial set. For example, it may use
> > one configuration for audio playback, but use another when you connect a
> > BT audio device.
> 
> Right.  I forgot this point.
> 
With a second thought on this, we can still do this as long as we have
mxc_audmux_v2_configure_port() exported.  For init-time setup, we can
just do it in audmux driver probe function.

-- 
Regards,
Shawn
