From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/3] ASoC: stm32: spdifrx: change trace level on iec control
Date: Mon, 6 May 2019 14:44:05 +0200
Message-ID: <1557146646-18150-3-git-send-email-olivier.moysan@st.com>
References: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557146646-18150-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com
Cc: benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Change trace level to debug to avoid spurious messages.
Return quietly when accessing iec958 control, while no
S/PDIF signal is available.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index aa83b50efabb..3d64200edbb5 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -496,7 +496,7 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	if (wait_for_completion_interruptible_timeout(&spdifrx->cs_completion,
 						      msecs_to_jiffies(100))
 						      <= 0) {
-		dev_err(&spdifrx->pdev->dev, "Failed to get control data\n");
+		dev_dbg(&spdifrx->pdev->dev, "Failed to get control data\n");
 		ret = -EAGAIN;
 	}
 
-- 
2.7.4
