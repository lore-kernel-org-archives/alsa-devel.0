From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: control: Hardening for potential
	Spectre v1
Date: Tue, 24 Apr 2018 09:56:14 +0200
Message-ID: <20180424075619.29602-4-tiwai@suse.de>
References: <20180424075619.29602-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 17EB026769C
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:56:44 +0200 (CEST)
In-Reply-To: <20180424075619.29602-1-tiwai@suse.de>
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

As the recent Smatch warned, a few places in ALSA control core codes
may expand the array directly from the user-space value with
speculation:

  sound/core/control.c:1003 snd_ctl_elem_lock() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:1031 snd_ctl_elem_unlock() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:844 snd_ctl_elem_info() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:891 snd_ctl_elem_read() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:939 snd_ctl_elem_write() warn: potential spectre issue 'kctl->vd'

Although all these seem doing only the first load without further
reference, we may want to stay in a safer side, so hardening with
array_index_nospec() would still make sense.

In this patch, we put array_index_nospec() to the common
snd_ctl_get_ioff*() helpers instead of each caller.  They are also
referred from some drivers, too, and basically all usages are to
calculate the array index from the user-space value.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/control.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index ca13a44ae9d4..6011a58d3e20 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/wait.h>
+#include <linux/nospec.h>
 #include <sound/asound.h>
 
 #define snd_kcontrol_chip(kcontrol) ((kcontrol)->private_data)
@@ -148,12 +149,14 @@ int snd_ctl_get_preferred_subdevice(struct snd_card *card, int type);
 
 static inline unsigned int snd_ctl_get_ioffnum(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
 {
-	return id->numid - kctl->id.numid;
+	unsigned int ioff = id->numid - kctl->id.numid;
+	return array_index_nospec(ioff, kctl->count);
 }
 
 static inline unsigned int snd_ctl_get_ioffidx(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
 {
-	return id->index - kctl->id.index;
+	unsigned int ioff = id->index - kctl->id.index;
+	return array_index_nospec(ioff, kctl->count);
 }
 
 static inline unsigned int snd_ctl_get_ioff(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
-- 
2.16.3
