From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH] snd-atmel-abdac: increase periods_min to 6
	instead of 4
Date: Thu,  2 Apr 2009 13:42:26 +0200
Message-ID: <1238672546-14785-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 79902103842
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 13:42:27 +0200 (CEST)
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

This patch increases periods_min to 6 from 4, this will remove any
hickups where the buffer is not filled fast enough from user space.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/abdac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index aeda7cf..232de1e 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -176,7 +176,7 @@ static struct snd_pcm_hardware atmel_abdac_hw = {
 	.buffer_bytes_max	= 64 * 4096,
 	.period_bytes_min	= 4096,
 	.period_bytes_max	= 4096,
-	.periods_min		= 4,
+	.periods_min		= 6,
 	.periods_max		= 64,
 };
 
-- 
1.5.6.3
