From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Remove incorrect snd_BUG_ON() usages
Date: Tue,  2 Jan 2018 15:01:51 +0100
Message-ID: <20180102140151.3675-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14346266DD5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 15:02:00 +0100 (CET)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

syzkaller triggered kernel warnings through PCM OSS emulation at
closing a stream:
  WARNING: CPU: 0 PID: 3502 at sound/core/pcm_lib.c:1635
  snd_pcm_hw_param_first+0x289/0x690 sound/core/pcm_lib.c:1635
  Call Trace:
  ....
   snd_pcm_hw_param_near.constprop.27+0x78d/0x9a0 sound/core/oss/pcm_oss.c:457
   snd_pcm_oss_change_params+0x17d3/0x3720 sound/core/oss/pcm_oss.c:969
   snd_pcm_oss_make_ready+0xaa/0x130 sound/core/oss/pcm_oss.c:1128
   snd_pcm_oss_sync+0x257/0x830 sound/core/oss/pcm_oss.c:1638
   snd_pcm_oss_release+0x20b/0x280 sound/core/oss/pcm_oss.c:2431
   __fput+0x327/0x7e0 fs/file_table.c:210
   ....

This happens while it tries to open and set up the aloop device
concurrently.  The warning above (invoked from snd_BUG_ON() macro) is
to detect the unexpected logical error where snd_pcm_hw_refine() call
shouldn't fail.  The theory is true for the case where the hw_params
config rules are static.  But for an aloop device, the hw_params rule
condition does vary dynamically depending on the connected target;
when another device is opened and changes the parameters, the device
connected in another side is also affected, and it caused the error
from snd_pcm_hw_refine().

That is, the simplest "solution" for this is to remove the incorrect
assumption of static rules, and treat such an error as a normal error
path.  As there are a couple of other places using snd_BUG_ON()
incorrectly, this patch removes these spurious snd_BUG_ON() calls.

Reported-by: syzbot+6f11c7e2a1b91d466432@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 1 -
 sound/core/pcm_lib.c     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e49f448ee04f..ceaa51f76591 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -455,7 +455,6 @@ static int snd_pcm_hw_param_near(struct snd_pcm_substream *pcm,
 		v = snd_pcm_hw_param_last(pcm, params, var, dir);
 	else
 		v = snd_pcm_hw_param_first(pcm, params, var, dir);
-	snd_BUG_ON(v < 0);
 	return v;
 }
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 10e7ef7a8804..db7894bb028c 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1632,7 +1632,7 @@ int snd_pcm_hw_param_first(struct snd_pcm_substream *pcm,
 		return changed;
 	if (params->rmask) {
 		int err = snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
@@ -1678,7 +1678,7 @@ int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm,
 		return changed;
 	if (params->rmask) {
 		int err = snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
-- 
2.15.1
