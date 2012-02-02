From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
Date: Thu, 2 Feb 2012 09:24:57 -0200
Message-ID: <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
	<1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, shawn.guo@linaro.org, Dirk Behme <dirk.behme@de.bosch.com>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Hi Richard,

On Thu, Feb 2, 2012 at 12:12 AM, Richard Zhao <richard.zhao@linaro.org>=
 wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> =C2=A0arch/arm/boot/dts/imx6q-sabrelite.dts | =C2=A0 12 ++++++++++++
> =C2=A01 files changed, 12 insertions(+), 0 deletions(-)

I would like to test your audio support patch on mx6sabrelite, but the
missing sound/soc/imx-sgtl5000.c does not allow me to do it.

I think you would better introduce sound/soc/imx-sgtl5000.c first (on
separate patch series) so that people could test this patch without
using the imx-sgtl5000.c implementation from the Linaro kernel.

Without imx-sgtl5000.c in place, this patch only introduces dead code
at the moment.

Regards,

=46abio Estevam
