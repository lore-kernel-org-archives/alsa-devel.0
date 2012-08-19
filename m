From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/10] sound/soc/fsl/imx-sgtl5000.c: fix error
	return code
Date: Sun, 19 Aug 2012 09:02:52 +0200
Message-ID: <1345359780-18647-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
 (mail4-relais-sop.national.inria.fr [192.134.164.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 32DAC264F10
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 08:33:18 +0200 (CEST)
In-Reply-To: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize ret on the second call to imx_audmux_v2_configure_port so that
the subsequent test checks that result and not the previous one.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/fsl/imx-sgtl5000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index fb21b17..199408e 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -94,7 +94,7 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "audmux internal port setup failed\n");
 		return ret;
 	}
-	imx_audmux_v2_configure_port(ext_port,
+	ret = imx_audmux_v2_configure_port(ext_port,
 			IMX_AUDMUX_V2_PTCR_SYN,
 			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
 	if (ret) {
