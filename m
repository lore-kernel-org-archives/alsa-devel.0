From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Tue, 14 Feb 2012 09:35:07 +0800
Message-ID: <20120214013506.GA3276@b20223-02.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, kernel@pengutronix.de, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, eric.miao@linaro.org, eric@eukrea.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 05, 2012 at 12:50:15PM +0800, Richard Zhao wrote:
>=20
>=20
> Shawn Guo <shawn.guo@linaro.org> wrote:
>=20
> >On Fri, Feb 03, 2012 at 10:15:54AM +0800, Richard Zhao wrote:
> >> adding Eric B=E9nard.
> >>=20
> >> On Thu, Feb 02, 2012 at 09:58:07PM +0800, Richard Zhao wrote:
> >> > On Thu, Feb 02, 2012 at 09:09:03PM +0800, Shawn Guo wrote:
> >> > > On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> >> > > > On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
> >> > > > > On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> >> > > > > > On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao
> >wrote:
> >> > > > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> >> > > > > > > ---
> >> > > > > > >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++=
++
> >> > > > > > >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> >> > > > > > >  2 files changed, 11 insertions(+), 0 deletions(-)
> >> > > > > > >=20
> >> > > > > > Hmm, let's see who are actually using
> >mxc_audmux_v2_configure_port().
> >> > > > > >=20
> >> > > > > > $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> >> > > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:   =20
> >mxc_audmux_v2_configure_port(0,
> >> > > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:   =20
> >mxc_audmux_v2_configure_port(4,
> >> > > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:   =20
> >mxc_audmux_v2_configure_port(0,
> >> > > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:   =20
> >mxc_audmux_v2_configure_port(3,
> >> > > > > > arch/arm/mach-imx/mach-pcm043.c:365:  =20
> >mxc_audmux_v2_configure_port(3,
> >> > > > > > arch/arm/mach-imx/mach-pcm043.c:371:  =20
> >mxc_audmux_v2_configure_port(0,
> >> It's machine specific code, though audmux driver is common. Might =
be
> >ok?
> >
> >With audmux driver moved out, it's not ok to me to have board file
> >call this function.
> >
> >> The asoc machine file for the above 3 boards is not platform drive=
r,
> >and
> >> don't get any plat info.
> >
> >It can be nicely solved if we do these initial setup in audmux drive=
r
> >probe function with the configuration data retrieved from audmux
> >platform data or device tree.
> no, it is asoc machine driver to have machine specific code.=20
> the machine driver do not correspond to any hw device, which cause ha=
rd
> to bind dt or create platform device.
I'll have to keep audmux driver in arch/, till ASOC machine driver
has a way to get platfrom parameters.

Thanks
Richard
> >
> >--=20
> >Regards,
> >Shawn
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
>=20

