From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] ASoC: qcom: common: Mark links as nonatomic
Date: Mon, 17 Jun 2019 22:29:09 -0700
Message-ID: <20190618052909.32586-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4B04F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 07:29:14 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id r7so6956347pfl.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 22:29:14 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The interface used to communicate with the DSP can sleep, so mark the
links as nonatomic. This prevents various sleep while atomic errors when
bringing up the audio interface.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 97488b5cc515..2c7348ddbbb3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -116,6 +116,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
+		link->nonatomic = 1;
 		link->dpcm_playback = 1;
 		link->dpcm_capture = 1;
 		link->stream_name = link->name;
-- 
2.18.0
