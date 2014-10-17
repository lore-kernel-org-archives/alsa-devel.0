From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: arm64: use the same dma mmap codepath
	both for arm and arm64
Date: Fri, 17 Oct 2014 12:43:34 -0700
Message-ID: <1413575014-19873-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f202.google.com (mail-yk0-f202.google.com
 [209.85.160.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 07CD22652E8
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 21:43:39 +0200 (CEST)
Received: by mail-yk0-f202.google.com with SMTP id q9so101632ykb.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 12:43:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

This avoids following kernel crash when try to playback on arm64

[  107.497203] [<ffffffc00046b310>] snd_pcm_mmap_data_fault+0x90/0xd4
[  107.503405] [<ffffffc0001541ac>] __do_fault+0xb0/0x498
[  107.508565] [<ffffffc0001576a0>] handle_mm_fault+0x224/0x7b0
[  107.514246] [<ffffffc000092640>] do_page_fault+0x11c/0x310
[  107.519738] [<ffffffc000081100>] do_mem_abort+0x38/0x98

Tested: backported to 3.14 and tried to playback on arm64 machine
Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8cd2f93..a95356f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3193,7 +3193,7 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 
 #ifndef ARCH_HAS_DMA_MMAP_COHERENT
 /* This should be defined / handled globally! */
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 #define ARCH_HAS_DMA_MMAP_COHERENT
 #endif
 #endif
-- 
2.1.0.rc2.206.gedb03e5
