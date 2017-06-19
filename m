From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [PATCH] oss: Fix a sleep-in-atomic bug in midi_outc
Date: Mon, 19 Jun 2017 10:56:23 +0800
Message-ID: <1497840983-5023-1-git-send-email-baijiaju1990@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by alsa0.perex.cz (Postfix) with ESMTP id A7EE72668F0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 04:53:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@163.com>, linux-kernel@vger.kernel.org
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
