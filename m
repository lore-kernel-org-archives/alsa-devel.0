From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] ALSA: usb: Fix potential NULL pointer
	dereference in comm.c
Date: Wed, 21 Nov 2012 14:36:57 +0530
Message-ID: <1353488819-13902-4-git-send-email-sachin.kamat@linaro.org>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 54C99265CB8
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:13:24 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id fb11so2407278pad.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:13:23 -0800 (PST)
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

'rt' was dereferenced before the NULL check.
Moved the code after the check.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/usb/6fire/comm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
index 6c3d531..1a75c36 100644
--- a/sound/usb/6fire/comm.c
+++ b/sound/usb/6fire/comm.c
@@ -129,12 +129,13 @@ int __devinit usb6fire_comm_init(struct sfire_chip *chip)
 {
 	struct comm_runtime *rt = kzalloc(sizeof(struct comm_runtime),
 			GFP_KERNEL);
-	struct urb *urb = &rt->receiver;
+	struct urb *urb;
 	int ret;
 
 	if (!rt)
 		return -ENOMEM;
 
+	urb = &rt->receiver;
 	rt->serial = 1;
 	rt->chip = chip;
 	usb_init_urb(urb);
-- 
1.7.4.1
