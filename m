From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
Date: Thu, 21 Feb 2019 07:29:05 -0300
Message-ID: <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
References: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu.

On Thu, Feb 21, 2019 at 6:53 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@freescale.com>

Better use your nxp.com address as the freescale.com domain is gone
for a long time.

> There is very low possibility ( < 0.1% ) that channel swap happened
> in beginning when multi output/input pin is enabled. The issue is
> that hardware can't send data to correct pin in the begginning with

s/begginning/beginning

> the normal enable flow.
>
> This is hardware issue, the workaround flow is that: Each time

Is there an erratum reference for this issue? If so, please add it here.

> playback/recording, firstly clear the xSMA/xSMB, then enable TE/RE,
> then enable xSMB and xSMA (xSMB must be enabled before xSMA).
> Which is to use the xSMA as the trigger start register, previously
> the xCR_TE or xCR_RE is the bit for starting

Please add a Fixes tag and Cc stable.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
