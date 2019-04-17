From: <twischer@de.adit-jv.com>
Subject: [PATCH] ALSA: pcm: Enable MMAP status and control for ARMv7 and ARMv8
Date: Wed, 17 Apr 2019 10:46:11 +0200
Message-ID: <1555490771-13242-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Since ARMv7 hardware cache coherence is supported.
"The SCU maintains coherency between the individual data caches in the
Cortex-A5 MPCore processor using a variation of the MOESI protocol" [1].

Therefore this patch enables the MMAP access to the status and control
structures. This avoids HWSYYNC ioctl calls and therefore lowers the CPU
usage.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0434c/
BABJECBF.html

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1d84529..b8019ef 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3225,7 +3225,8 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
  * Only on coherent architectures, we can mmap the status and the control records
  * for effcient data transfer.  On others, we have to use HWSYNC ioctl...
  */
-#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA)
+#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA) || \
+	(defined(CONFIG_ARM) && defined(CONFIG_CPU_V7)) || defined(CONFIG_ARM64)
 /*
  * mmap status record
  */
-- 
2.7.4
