From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] ASoC: qcom: change PTR_ERR argument
Date: Thu, 17 Sep 2015 10:47:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1509171047040.2399@hadrien>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr> <1440957911-7687-2-git-send-email-Julia.Lawall@lip6.fr> <20150914180425.GB12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914180425.GB12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Apply PTR_ERR to the value that was recently assigned.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
@@

if (IS_ERR(x) || ...) {
  ... when any
      when != IS_ERR(...)
(
   PTR_ERR(x)
|
*  PTR_ERR(y)
)
  ... when any
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/qcom/lpass-cpu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 23f3d59..94beb99 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -438,7 +438,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
 			dev_err(&pdev->dev,
 				"%s() error getting mi2s-bit-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
+				__func__,
+				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
 			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
 		}
 	}
