From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Date: Sat, 16 Feb 2019 11:19:23 -0200
Message-ID: <CAOMZO5ALVAhmBrM_e_2LnzfyhSLPQbe4hsdXAtUMZkQL3YXQHg@mail.gmail.com>
References: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

On Fri, Feb 15, 2019 at 9:04 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Please add a Fixes tag and Cc stable.

Also, it seems that Mark Brown is not on Cc. Please Cc him in v2.

Thanks
