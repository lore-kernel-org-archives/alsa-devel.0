From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: imx-sgtl5000: Do not enter the
 error path on success
Date: Wed, 17 Apr 2013 23:06:50 -0300
Message-ID: <CAOMZO5DQ5dWgWuJpMSZ8r-D+i_TMLqJOuvSEqJT6erD=0x2BPg@mail.gmail.com>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
 <20130418012938.GC20563@S2101-09.ap.freescale.net>
 <20130418013838.GA14102@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com
 [209.85.212.46])
 by alsa0.perex.cz (Postfix) with ESMTP id C978A265D8E
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 04:06:51 +0200 (CEST)
Received: by mail-vb0-f46.google.com with SMTP id 11so1793667vbe.19
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 19:06:50 -0700 (PDT)
In-Reply-To: <20130418013838.GA14102@S2101-09.ap.freescale.net>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 10:38 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Well, clk_put() shouldn't be called on success, but of_node_put()
> should.

Ok, then tomorrow I will send v2 as:

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 9584e78..5a6aaa3 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -174,6 +174,11 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	}

 	platform_set_drvdata(pdev, data);
+	of_node_put(ssi_np);
+	of_node_put(codec_np);
+
+	return 0;
+
 clk_fail:
 	clk_put(data->codec_clk);
 fail:
