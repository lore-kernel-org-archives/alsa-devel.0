From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/12] ALSA: korg1212: Add __force annotation
	to cast in user-copy callbacks
Date: Wed, 25 Jul 2018 23:00:56 +0200
Message-ID: <20180725210057.18017-12-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D454D267784
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D4B78B380
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The user-copy callbacks in korg1212 driver contain the explicit cast
from a user pointer to a kernel pointer, but they missed __force
prefix.  It's mandatory for converting between them.

Spotted by sparse, a warning like:
  sound/pci/korg1212/korg1212.c:1329:33: warning: cast removes address space of expression

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 4206ba44d8bb..4e189a93f475 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1326,7 +1326,7 @@ static int snd_korg1212_copy_to(struct snd_pcm_substream *substream,
 		}
 #endif
 		if (in_kernel)
-			memcpy((void *)dst, src, size);
+			memcpy((__force void *)dst, src, size);
 		else if (copy_to_user(dst, src, size))
 			return -EFAULT;
 		src++;
@@ -1365,7 +1365,7 @@ static int snd_korg1212_copy_from(struct snd_pcm_substream *substream,
 		}
 #endif
 		if (in_kernel)
-			memcpy((void *)dst, src, size);
+			memcpy(dst, (__force void *)src, size);
 		else if (copy_from_user(dst, src, size))
 			return -EFAULT;
 		dst++;
-- 
2.18.0
