From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 214/276] ASoC: eukrea-tlv320: fix a leaked
	reference by adding missing of_node_put
Date: Wed, 29 May 2019 20:06:12 -0700
Message-ID: <20190530030538.511082959@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 166BDF8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 05:17:55 +0200 (CEST)
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

[ Upstream commit b820d52e7eed7b30b2dfef5f4213a2bc3cbea6f3 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/eukrea-tlv320.c:121:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.
./sound/soc/fsl/eukrea-tlv320.c:127:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 191426a6d9adf..30a3d68b5c033 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -118,13 +118,13 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-int-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 		ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-ext-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 
 		/*
-- 
2.20.1
