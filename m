From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/2] ASoC: stm32: spdifrx: Use default dai name
Date: Wed, 31 Jan 2018 17:47:03 +0100
Message-ID: <1517417223-21899-3-git-send-email-olivier.moysan@st.com>
References: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 8EA9A267686
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 17:47:46 +0100 (CET)
In-Reply-To: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Use dai name provided by framework from dev_name() function.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 42ad2ae..373df4f 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -819,7 +819,6 @@ static void stm32_spdifrx_shutdown(struct snd_pcm_substream *substream,
 
 static struct snd_soc_dai_driver stm32_spdifrx_dai[] = {
 	{
-		.name = "spdifrx-capture-cpu-dai",
 		.probe = stm32_spdifrx_dai_probe,
 		.capture = {
 			.stream_name = "CPU-Capture",
-- 
1.9.1
