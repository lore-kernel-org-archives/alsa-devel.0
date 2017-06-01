From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [PATCH] oss: Fix a sleep-in-atomic bug in midi_outc
Date: Thu,  1 Jun 2017 17:33:43 +0800
Message-ID: <1496309623-23072-1-git-send-email-baijiaju1990@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>
List-Id: alsa-devel@alsa-project.org

The driver may sleep under a spin lock, and the function call path is:
midi_outc (acquire the lock by spin_lock_irqsave)
  oss_broken_sleep_on
    schedule_timeout --> may sleep

To fix it, the lock is released before oss_broken_sleep_on, and the lock 
is acquired again after this function.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 sound/oss/sequencer.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/oss/sequencer.c b/sound/oss/sequencer.c
index f19da4b..3d95d752 100644
--- a/sound/oss/sequencer.c
+++ b/sound/oss/sequencer.c
@@ -1211,7 +1211,9 @@ static void midi_outc(int dev, unsigned char data)
 
 	spin_lock_irqsave(&lock,flags);
  	while (n && !midi_devs[dev]->outputc(dev, data)) {
+		spin_unlock_irqrestore(&lock, flags);
 		oss_broken_sleep_on(&seq_sleeper, HZ/25);
+		spin_lock_irqsave(&lock, flags);
   		n--;
   	}
 	spin_unlock_irqrestore(&lock,flags);
-- 
1.7.9.5
