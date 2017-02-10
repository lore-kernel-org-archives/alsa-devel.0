From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] ASoC: fsl_sai: support more than 2 channels
Date: Fri, 10 Feb 2017 19:42:43 +0100
Message-ID: <20170210184243.15901-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 401D5266D1E
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 19:42:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

The FSL SAI can support up to 32 channels using TDM. Report that value so
they can actually be used.

Tested using 8 channels.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/fsl/fsl_sai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9fadf7e31c5f..18e5ce81527d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -668,7 +668,7 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
@@ -677,7 +677,7 @@ static struct snd_soc_dai_driver fsl_sai_dai = {
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
-- 
2.11.0
