From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH v2 4/9] snd-atmel-ac97c: set correct size for
	buffer hardware parameter
Date: Thu,  2 Apr 2009 08:21:13 +0200
Message-ID: <1238653278-2546-4-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1238653278-2546-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-3-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 88EC324432
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 08:21:19 +0200 (CEST)
In-Reply-To: <1238653278-2546-3-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will set a proper maximum bytes for the buffer, which is:
channels * bytes per sample * maximum periods * maximum bytes per period.

It also sets the minimum periods to 6, a value chosen from testing, with
a minimum of 6 periods the system has good time to fill in new audio
data without skipping.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 4e8f66d..c9bc345 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -151,10 +151,10 @@ static struct snd_pcm_hardware atmel_ac97c_hw = {
 	.rate_max		= 48000,
 	.channels_min		= 1,
 	.channels_max		= 2,
-	.buffer_bytes_max	= 64 * 4096,
+	.buffer_bytes_max	= 2 * 2 * 64 * 2048,
 	.period_bytes_min	= 4096,
 	.period_bytes_max	= 4096,
-	.periods_min		= 4,
+	.periods_min		= 6,
 	.periods_max		= 64,
 };
 
-- 
1.5.6.3
