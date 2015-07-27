From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: lpass-ipq806x: Staticise local
	symbols
Date: Mon, 27 Jul 2015 10:56:24 +0200
Message-ID: <1437987388-9706-3-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D84F260714
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:36 +0200 (CEST)
In-Reply-To: <1437987388-9706-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

ipq806x_data is not used outside this file, so it can be static.
Fixes the following sparse warning:

	sound/soc/qcom/lpass-ipq806x.c:76:22: warning: symbol 'ipq806x_data'
		was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/qcom/lpass-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 7356d3a..7a41679 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -73,7 +73,7 @@ static int ipq806x_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 	return 0;
 }
 
-struct lpass_variant ipq806x_data = {
+static struct lpass_variant ipq806x_data = {
 	.i2sctrl_reg_base	= 0x0010,
 	.i2sctrl_reg_stride	= 0x04,
 	.i2s_ports		= 5,
-- 
2.1.4
