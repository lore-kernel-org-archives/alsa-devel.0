From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: pcm: Fix potential Spectre v1 vulnerability
Date: Wed, 12 Dec 2018 15:36:28 -0600
Message-ID: <20181212213628.GA29911@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

stream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/pcm.c:140 snd_pcm_control_ioctl() warn: potential spectre issue 'pcm->streams' [r] (local cap)

Fix this by sanitizing stream before using it to index pcm->streams

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index fdb9b92fc8d6..23141003a90d 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -32,6 +32,8 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
+#include <linux/nospec.h>
+
 #include "pcm_local.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
@@ -129,6 +131,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 				return -EFAULT;
 			if (stream < 0 || stream > 1)
 				return -EINVAL;
+			stream = array_index_nospec(stream, 2);
 			if (get_user(subdevice, &info->subdevice))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
-- 
2.17.1
