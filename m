From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 4/7] snd-atmel-ac97c: set correct size for
	buffer hardware parameter
Date: Tue, 24 Mar 2009 13:47:47 +0100
Message-ID: <1237898870-15780-5-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EC493103820
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:52 +0100 (CET)
In-Reply-To: <1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will set a proper maximum bytes for the buffer, which is:
channels * bytes per sample * maximum periods * maximum bytes per period.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 4e8f66d..9748225 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -151,7 +151,7 @@ static struct snd_pcm_hardware atmel_ac97c_hw = {
 	.rate_max		= 48000,
 	.channels_min		= 1,
 	.channels_max		= 2,
-	.buffer_bytes_max	= 64 * 4096,
+	.buffer_bytes_max	= 2 * 2 * 64 * 2048,
 	.period_bytes_min	= 4096,
 	.period_bytes_max	= 4096,
 	.periods_min		= 4,
-- 
1.5.6.3
