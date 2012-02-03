From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Fri, 3 Feb 2012 21:32:42 +0800
Message-ID: <20120203133240.GB12915@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120203021554.GE32403@b20223-02.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: eric@eukrea.com, s.hauer@pengutronix.de, alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 03, 2012 at 10:15:54AM +0800, Richard Zhao wrote:
> adding Eric B=E9nard.
>=20
> On Thu, Feb 02, 2012 at 09:58:07PM +0800, Richard Zhao wrote:
> > On Thu, Feb 02, 2012 at 09:09:03PM +0800, Shawn Guo wrote:
> > > On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> > > > On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
> > > > > On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> > > > > > On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrot=
e:
> > > > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > > > > ---
> > > > > > >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
> > > > > > >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> > > > > > >  2 files changed, 11 insertions(+), 0 deletions(-)
> > > > > > >=20
> > > > > > Hmm, let's see who are actually using mxc_audmux_v2_configu=
re_port().
> > > > > >=20
> > > > > > $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> > > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:     mxc=
_audmux_v2_configure_port(0,
> > > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:     mxc=
_audmux_v2_configure_port(4,
> > > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:     mxc=
_audmux_v2_configure_port(0,
> > > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:     mxc=
_audmux_v2_configure_port(3,
> > > > > > arch/arm/mach-imx/mach-pcm043.c:365:    mxc_audmux_v2_confi=
gure_port(3,
> > > > > > arch/arm/mach-imx/mach-pcm043.c:371:    mxc_audmux_v2_confi=
gure_port(0,
> It's machine specific code, though audmux driver is common. Might be =
ok?

With audmux driver moved out, it's not ok to me to have board file
call this function.

> The asoc machine file for the above 3 boards is not platform driver, =
and
> don't get any plat info.

It can be nicely solved if we do these initial setup in audmux driver
probe function with the configuration data retrieved from audmux
platform data or device tree.

--=20
Regards,
Shawn
