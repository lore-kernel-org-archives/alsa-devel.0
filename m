From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] ALSA: usb-audio: Return -ENOMEM on memory
	alloc failure in format.c
Date: Wed, 21 Nov 2012 14:36:58 +0530
Message-ID: <1353488819-13902-5-git-send-email-sachin.kamat@linaro.org>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CFA1265CC0
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:13:27 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so2407278pad.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:13:27 -0800 (PST)
In-Reply-To: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Return -ENOMEM instead of -1 to silence the following smatch warning:
sound/usb/format.c:170 parse_audio_format_rates_v1() warn:
returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/usb/format.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index ddfef57..d033d4d 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -167,7 +167,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
 		if (fp->rate_table == NULL) {
 			snd_printk(KERN_ERR "cannot malloc\n");
-			return -1;
+			return -ENOMEM;
 		}
 
 		fp->nr_rates = 0;
-- 
1.7.4.1
