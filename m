From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 14 Aug 2013 14:34:45 +0800
Message-ID: <20130814063444.GG31651@MrMyself>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
 <20130814032658.GA16915@S2101-09.ap.freescale.net>
 <20130814053016.GF31651@MrMyself>
 <20130814063931.GB31141@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id CCE6E2619E1
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 08:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130814063931.GB31141@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2013 at 02:39:33PM +0800, Shawn Guo wrote:
> We only need to maintain those versions that require different
> programming model in the list.  For example, if S/PDIF on Vybrid
> is completely compatible with imx6q one and uses the exactly same
> programming model, we do not need to maintain a compatible string
> for Vybrid S/PDIF at all.  Instead, we only need to have something
> like below in Vybrid dts file, and S/PDIF driver will just work for it.
> 
> 	compatible = "fsl,vf600-spdif", "fsl,imx6q-spdif";
> 
> Shawn

Clear. Thank you for the explain.

Then I think I can merely remain "fsl,imx6q-spdif" here,
because all other cases should be completely compatible
with this one. They are only different in the clock source
names list, which's already being specified in dts file.

Please correct me if you think this still isn't proper.

Best regards,
Nicolin Chen
