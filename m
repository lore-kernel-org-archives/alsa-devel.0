From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.0 249/346] ASoC: fsl_utils: fix a leaked
	reference by adding missing of_node_put
Date: Wed, 29 May 2019 20:05:22 -0700
Message-ID: <20190530030553.640391239@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DD1DF896EB
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 05:15:08 +0200 (CEST)
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

[ Upstream commit c705247136a523488eac806bd357c3e5d79a7acd ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/fsl_utils.c:74:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 38, but without a corresponding     object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 9981668ab5909..040d06b89f00a 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -71,6 +71,7 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 	iprop = of_get_property(dma_np, "cell-index", NULL);
 	if (!iprop) {
 		of_node_put(dma_np);
+		of_node_put(dma_channel_np);
 		return -EINVAL;
 	}
 	*dma_id = be32_to_cpup(iprop);
-- 
2.20.1
