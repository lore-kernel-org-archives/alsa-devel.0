From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Thu, 2 Feb 2012 21:09:03 +0800
Message-ID: <20120202130901.GE9773@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
	<1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
	<20120202085521.GB9773@S2101-09.ap.freescale.net>
	<20120202091132.GD9773@S2101-09.ap.freescale.net>
	<20120202092427.GB32403@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 06D2A103C73
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 13:56:41 +0100 (CET)
Received: by pbcc7 with SMTP id c7so2127847pbc.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Feb 2012 04:56:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120202092427.GB32403@b20223-02.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, eric.miao@linaro.org, patches@linaro.org, Richard Zhao <richard.zhao@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
> > On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> > > On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:
> > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > ---
> > > >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
> > > >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> > > >  2 files changed, 11 insertions(+), 0 deletions(-)
> > > > 
> > > Hmm, let's see who are actually using mxc_audmux_v2_configure_port().
> > > 
> > > $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:     mxc_audmux_v2_configure_port(0,
> > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:     mxc_audmux_v2_configure_port(4,
> > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:     mxc_audmux_v2_configure_port(0,
> > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:     mxc_audmux_v2_configure_port(3,
> > > arch/arm/mach-imx/mach-pcm043.c:365:    mxc_audmux_v2_configure_port(3,
> > > arch/arm/mach-imx/mach-pcm043.c:371:    mxc_audmux_v2_configure_port(0,
> I didn't grep arch/arm. where is pc043 asoc machine file?

It seems to be sound/soc/imx/phycore-ac97.c.

> > > 
> > As we are moving audmux into sound/soc/imx, it makes less sense to
> > still keep these calls in board files.
> It don't corrupt git bisect. We don't have to include it in this patch.

It's logically part of this series.

> >  Instead, I prefer to call it
> > from machine driver like what wm1133-ev1 does below.
> Maybe pass the info as asoc machine driver pdata.

Sounds good.

> >  Or we can simply
> > make the it a audmux-self call with 3 parameters it needs retrieved
> > from platform_data or device tree, so that machine driver does not
> > even bother with the call.  Makes sense?
> audux configuration may change after initial set. For example, it may use
> one configuration for audio playback, but use another when you connect a
> BT audio device.

Right.  I forgot this point.

-- 
Regards,
Shawn
