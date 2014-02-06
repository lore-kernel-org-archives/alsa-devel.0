From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ALSA: pcm: export some constraint functions
Date: Thu, 6 Feb 2014 09:41:48 +0100
Message-ID: <20140206091402.5F54D940120@smtp1-g21.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3C5265158
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 10:14:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The functions snd_pcm_hw_constraint_mask() and
snd_pcm_hw_constraint_mask64() are needed to add audio constraints
to substreams at open/startup time.
This patch makes them available to ALSA modules.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/core/pcm_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a210467..aea4972 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1219,6 +1219,7 @@ int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime, snd_pcm_hw_param
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_hw_constraint_mask);
 
 /**
  * snd_pcm_hw_constraint_mask64 - apply the given bitmap mask constraint
@@ -1242,6 +1243,7 @@ int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_par
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_hw_constraint_mask64);
 
 /**
  * snd_pcm_hw_constraint_integer - apply an integer constraint to an interval
-- 
1.9.rc1
