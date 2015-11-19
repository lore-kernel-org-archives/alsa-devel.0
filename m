From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 1/4] ASoC: sti: remove wrong error message
Date: Thu, 19 Nov 2015 14:54:07 +0100
Message-ID: <1447941250-344-2-git-send-email-moise.gergaud@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A695C26153A
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 14:54:24 +0100 (CET)
In-Reply-To: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_reader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index f791239..819eeaf 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -346,7 +346,6 @@ int uni_reader_init(struct platform_device *pdev,
 	reader->hw = &uni_reader_pcm_hw;
 	reader->dai_ops = &uni_reader_dai_ops;
 
-	dev_err(reader->dev, "%s: enter\n", __func__);
 	ret = uni_reader_parse_dt(pdev, reader);
 	if (ret < 0) {
 		dev_err(reader->dev, "Failed to parse DeviceTree");
-- 
1.9.1
