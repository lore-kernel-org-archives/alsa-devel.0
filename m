From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.1 276/405] ASoC: wcd9335: fix a leaked
	reference by adding missing of_node_put
Date: Wed, 29 May 2019 20:04:34 -0700
Message-ID: <20190530030554.859752508@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6807F8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 05:11:46 +0200 (CEST)
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Wen Yang <wen.yang99@zte.com.cn>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

[ Upstream commit 64b92de9603f22b5455da925ee57268ef7fb4e80 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/codecs/wcd9335.c:5193:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 5183, but without a correspon    ding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com> (commit_signer:1/11=9%,authored:1/11=9%)
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 981f88a5f6154..a04a7cedd99de 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5188,6 +5188,7 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 
 	wcd->slim = sdev;
 	wcd->slim_ifc_dev = of_slim_get_device(sdev->ctrl, ifc_dev_np);
+	of_node_put(ifc_dev_np);
 	if (!wcd->slim_ifc_dev) {
 		dev_err(dev, "Unable to get SLIM Interface device\n");
 		return -EINVAL;
-- 
2.20.1
