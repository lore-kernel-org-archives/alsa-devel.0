From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: sun4i-codec: Fix error return code
	in sun4i_codec_probe()
Date: Wed, 10 Aug 2016 13:42:34 +0000
Message-ID: <1470836554-11569-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id F2FAA265487
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 15:42:51 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id g202so2903413pfb.1
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:42:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, kuninori.morimoto.gx@renesas.com, emilio@elopez.com.ar, hdegoede@redhat.com, ats@offog.org, fengguang.wu@intel.com
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyj.lk@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Fix to return error code -ENOMEM instead of 0 when create card
failed, as done elsewhere in this function.

Fixes: 45fb6b6f2aa3 ("ASoC: sunxi: add support for the on-chip
codec on early Allwinner SoCs")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 0e19c50..e741659 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -846,6 +846,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	card = sun4i_codec_create_card(&pdev->dev);
 	if (!card) {
 		dev_err(&pdev->dev, "Failed to create our card\n");
+		ret = -ENOMEM;
 		goto err_unregister_codec;
 	}
