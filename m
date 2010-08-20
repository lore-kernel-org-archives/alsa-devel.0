From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Make codec dai naming for WM8741
	consistent
Date: Fri, 20 Aug 2010 17:18:44 +0100
Message-ID: <1282321125-15761-2-git-send-email-ian@opensource.wolfsonmicro.com>
References: <1282321125-15761-1-git-send-email-ian@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64C872455B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:19:56 +0200 (CEST)
In-Reply-To: <1282321125-15761-1-git-send-email-ian@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 782fe53..fdd24da 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -311,7 +311,7 @@ static struct snd_soc_dai_ops wm8741_dai_ops = {
 };
 
 static struct snd_soc_dai_driver wm8741_dai = {
-	.name = "WM8741",
+	.name = "wm8741",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,  /* Mono modes not yet supported */
-- 
1.7.0.4
