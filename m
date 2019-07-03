From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 29/30] sound/pci: Use kmemdup rather than duplicating its implementation
Date: Wed,  3 Jul 2019 21:18:31 +0800
Message-ID: <20190703131831.26013-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: alsa-devel@alsa-project.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/pci/echoaudio/echoaudio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index b612a536a5a1..35bd3e7c8ce1 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2189,11 +2189,10 @@ static int snd_echo_resume(struct device *dev)
 	u32 pipe_alloc_mask;
 	int err;
 
-	commpage_bak = kmalloc(sizeof(*commpage), GFP_KERNEL);
+	commpage_bak = kmemdup(commpage, sizeof(*commpage), GFP_KERNEL);
 	if (commpage_bak == NULL)
 		return -ENOMEM;
 	commpage = chip->comm_page;
-	memcpy(commpage_bak, commpage, sizeof(*commpage));
 
 	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
 	if (err < 0) {
-- 
2.11.0
