From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_sai: Add driver suspend
 and resume to support MEGA Fast
Date: Tue, 11 Aug 2015 17:50:15 +0800
Message-ID: <20150811095014.GD28723@shlinux2>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
 <20150811091220.GA3008@Asurada-CZ80>
 <CAOMZO5Bs223E-gypxNM_GA6qrOc8yXO=yMH7UTCCU5VV_EbVOQ@mail.gmail.com>
 <20150811093448.GC28723@shlinux2>
 <CAOMZO5DPButcf=XbsPLLn6DF4oZKapjhg0OfktMjKf4hAAgpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 5847F2604DD
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 13:00:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DPButcf=XbsPLLn6DF4oZKapjhg0OfktMjKf4hAAgpdQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.com, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 07:46:40AM -0300, Fabio Estevam wrote:
> On Tue, Aug 11, 2015 at 6:34 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> 
> > I have sent the SDMA remap patch to community, but have no response now. I can share the patch for you.
> 
> Please share the link to your patch, thanks.

https://patchwork.kernel.org/patch/6850431/

The other patch i can't find the link:
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e391d63..73b28a1 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -934,7 +934,7 @@
                                         <&clks 0>, <&clks 0>;
                                clock-names = "bus", "mclk1", "mclk2", "mclk3";
                                dma-names = "rx", "tx";
-                               dmas = <&sdma 31 23 0>, <&sdma 32 23 0>;
+                               dmas = <&sdma 31 24 0>, <&sdma 32 24 0>;
                                dma-source = <&gpr 0 15 0 16>;
                                status = "disabled";
                        };
