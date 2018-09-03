From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: q6routing: initialize data correctly
Date: Mon,  3 Sep 2018 12:07:47 +0100
Message-ID: <20180903110747.10745-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D2C52673F4
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 13:10:18 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so270582wrd.1
 for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2018 04:10:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, bgoswami@codeaurora.org, rohitkr@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some of the router data fields are left as default zeros which are
valid dai ids, so initialize these to invalid value of -1.

Without intializing these correctly get_session_from_id() can return
incorrect session resulting in not closing the opened copp and messing
up with the copp ref count.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index dc94c5c53788..c6b51571be94 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -960,8 +960,10 @@ static int msm_routing_probe(struct snd_soc_component *c)
 {
 	int i;
 
-	for (i = 0; i < MAX_SESSIONS; i++)
+	for (i = 0; i < MAX_SESSIONS; i++) {
 		routing_data->sessions[i].port_id = -1;
+		routing_data->sessions[i].fedai_id = -1;
+	}
 
 	return 0;
 }
-- 
2.18.0
