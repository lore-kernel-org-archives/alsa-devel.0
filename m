From: voice <voice.shen@atmel.com>
Subject: [PATCH] atmel ac97c: using software reset instead
	hardware reset if not available
Date: Mon, 19 Dec 2011 17:57:52 +0800
Message-ID: <1324288672-29556-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 804CE245D4
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 10:58:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jm.lin@atmel.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, hong.xu@atmel.com, voice <voice.shen@atmel.com>, Hans-Christian.Egtvedt@atmel.com
List-Id: alsa-devel@alsa-project.org

Using software reset instead hardware reset if not available

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/atmel/ac97c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 6e5adde..73516f6 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -899,6 +899,10 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 		/* AC97 v2.2 specifications says minimum 1 us. */
 		udelay(2);
 		gpio_set_value(chip->reset_pin, 1);
+	} else {
+		ac97c_writel(chip, MR, AC97C_MR_WRST | AC97C_MR_ENA);
+		udelay(2);
+		ac97c_writel(chip, MR, AC97C_MR_ENA);
 	}
 }
 
-- 
1.6.3.3
