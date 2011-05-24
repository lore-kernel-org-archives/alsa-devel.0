From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 3/6] ASoC: davinci-pcm: increase the maximum
	channels
Date: Tue, 24 May 2011 14:50:17 -0400
Message-ID: <0627d11625ae11c83601978eb0c2a9dceef69652.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id F0D2110386A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:27 +0200 (CEST)
Received: by mail-vx0-f180.google.com with SMTP id 12so7658903vxk.11
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:26 -0700 (PDT)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Based on the registration of davinci-mcasp.1 in the davinci-evm platform
setup for da830 and dm6467, davinci-pcm can handle more than the currently
reported maximum channels of 2.

Increase the maximum channels to 384 to match the maximum reported by
davinci-mcasp.1.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 1e47267..9b5a9bf 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -75,7 +75,7 @@ static struct snd_pcm_hardware pcm_hardware_playback = {
 	.rate_min = 8000,
 	.rate_max = 96000,
 	.channels_min = 2,
-	.channels_max = 2,
+	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
 	.period_bytes_min = 32,
 	.period_bytes_max = 8 * 1024,
@@ -97,7 +97,7 @@ static struct snd_pcm_hardware pcm_hardware_capture = {
 	.rate_min = 8000,
 	.rate_max = 96000,
 	.channels_min = 2,
-	.channels_max = 2,
+	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
 	.period_bytes_min = 32,
 	.period_bytes_max = 8 * 1024,
-- 
1.7.4.1
