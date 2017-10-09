From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [PATCH] opl3: Fix a possible sleep-in-atomic bug in
	snd_opl3_find_patch
Date: Mon,  9 Oct 2017 10:35:27 +0800
Message-ID: <1507516527-4173-1-git-send-email-baijiaju1990@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 97A88266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 04:32:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, elfring@users.sourceforge.net, fabf@skynet.be
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@163.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The driver may sleep under a spinlock, and the function call path is:
snd_opl3_note_on (acquire the spinlock)
  snd_opl3_find_patch
    kzalloc(GFP_KERNEL) --> may sleep

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC.
This bug is found by my static analysis tool and my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 sound/drivers/opl3/opl3_synth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index ddcc1a3..2e1cb2b 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -325,7 +325,7 @@ struct fm_patch *snd_opl3_find_patch(struct snd_opl3 *opl3, int prog, int bank,
 	if (!create_patch)
 		return NULL;
 
-	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
+	patch = kzalloc(sizeof(*patch), GFP_ATOMIC);
 	if (!patch)
 		return NULL;
 	patch->prog = prog;
-- 
1.7.9.5
