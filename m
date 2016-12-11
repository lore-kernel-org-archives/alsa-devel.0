From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] pcm: fix wrong document references
	to PCM APIs which perform direct memory access with frame copying
Date: Sun, 11 Dec 2016 20:31:38 +0900
Message-ID: <20161211113138.32468-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2DA612666D7
 for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2016 12:31:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a design of ALSA PCM interface, for PCM frame transmission to/from
kernel space, applications can select from two options; direct memory access
or ioctl(2). Available options are decided depending on device capacity and
machine architecture. Applications can get available options by the first
entry of 'struct snd_pcm_hw_params.masks'.

When the mask includes 'SNDRV_PCM_ACCESS_MMAP_xxx', applications can use
direct memory access. For this use case, userspace library has two types
of PCM API. One is to expose a pointer over the memory to start
reading/writing PCM frames. Another is to copy PCM frames between the
memory and a given buffer.

Current documentation includes wrong references to these APIs to describe
their advantages/disadvantages. This confuses application developers
because the references indicate PCM APIs to execute ioctl(2) operation to
read/write PCM frames.

This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index f2ca02b..0cf740f 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -260,8 +260,9 @@ If you like to use the compatibility functions in mmap mode, there are
 read / write routines equaling to standard read / write transfers. Using
 these functions discards the benefits of direct access to memory region.
 See the #snd_pcm_mmap_readi(),
-#snd_pcm_writei(), #snd_pcm_readn()
-and #snd_pcm_writen() functions.
+#snd_pcm_mmap_writei(), #snd_pcm_mmap_readn()
+and #snd_pcm_mmap_writen() functions. These functions use
+#snd_pcm_areas_copy() internally.
 
 \section pcm_errors Error codes
 
-- 
2.9.3
