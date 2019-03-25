From: <twischer@de.adit-jv.com>
Subject: [PATCH 01/10] ALSA: aloop: Describe units of variables
Date: Mon, 25 Mar 2019 17:00:35 +0100
Message-ID: <1553529644-5654-2-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Describe the unit of the variables used to calculate the hw pointer
depending on jiffies ticks.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 8c3fbe1..70145e6 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -116,8 +116,10 @@ struct loopback_pcm {
 	/* flags */
 	unsigned int period_update_pending :1;
 	/* timer stuff */
-	unsigned int irq_pos;		/* fractional IRQ position */
-	unsigned int period_size_frac;
+	unsigned int irq_pos;		/* fractional IRQ position in jiffies
+					 * ticks
+					 */
+	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
-- 
2.7.4
