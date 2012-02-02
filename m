From: Richard Zhao <richard.zhao@linaro.org>
Subject: Re: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio
 codec
Date: Thu, 2 Feb 2012 21:49:09 +0800
Message-ID: <20120202134907.GA3015@richard-laptop>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, shawn.guo@linaro.org, Dirk Behme <dirk.behme@de.bosch.com>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 02, 2012 at 09:24:57AM -0200, Fabio Estevam wrote:
> Hi Richard,
>=20
> On Thu, Feb 2, 2012 at 12:12 AM, Richard Zhao <richard.zhao@linaro.or=
g> wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > =A0arch/arm/boot/dts/imx6q-sabrelite.dts | =A0 12 ++++++++++++
> > =A01 files changed, 12 insertions(+), 0 deletions(-)
>=20
> I would like to test your audio support patch on mx6sabrelite, but th=
e
> missing sound/soc/imx-sgtl5000.c does not allow me to do it.
I have a test branch. I'll push to my linaro git  on git.linaro.org tom=
orrow.
>=20
> I think you would better introduce sound/soc/imx-sgtl5000.c first (on
> separate patch series) so that people could test this patch without
> using the imx-sgtl5000.c implementation from the Linaro kernel.
>=20
> Without imx-sgtl5000.c in place, this patch only introduces dead code
> at the moment.
Each patch make sense too without sgtl5000.=20

Thanks
Richard
>=20
> Regards,
>=20
> Fabio Estevam
