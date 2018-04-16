From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: cmipci: Allocate with GFP_KERNEL
	instead of GFP_ATOMIC
Date: Mon, 16 Apr 2018 14:12:05 +0200
Message-ID: <20180416121206.27131-2-tiwai@suse.de>
References: <20180416121206.27131-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B0702673CB
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:12:09 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AF953AEF9
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 12:12:09 +0000 (UTC)
In-Reply-To: <20180416121206.27131-1-tiwai@suse.de>
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

save_mixer_state() is called in a sleepable context, so it's safe to
allocate with GFP_KERNEL instead of the current GFP_ATOMIC.  The
GFP_ATOMIC usage must have been based on an incorrect assumption in
the very old code base.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cmipci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 26a657870664..452cc79b44af 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1139,7 +1139,7 @@ static int save_mixer_state(struct cmipci *cm)
 		struct snd_ctl_elem_value *val;
 		unsigned int i;
 
-		val = kmalloc(sizeof(*val), GFP_ATOMIC);
+		val = kmalloc(sizeof(*val), GFP_KERNEL);
 		if (!val)
 			return -ENOMEM;
 		for (i = 0; i < CM_SAVED_MIXERS; i++) {
-- 
2.16.3
