From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: hda: Hardening for potential Spectre
	v1
Date: Tue, 24 Apr 2018 09:56:15 +0200
Message-ID: <20180424075619.29602-5-tiwai@suse.de>
References: <20180424075619.29602-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E09FD266E30
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:56:42 +0200 (CEST)
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

As the recent Smatch warned, one place in HD-audio hwdep ioctl codes
may expand the array directly from the user-space value with
speculation:
  sound/pci/hda/hda_local.h:467 get_wcaps() warn: potential spectre issue 'codec->wcaps'

As get_wcaps() itself is a fairly frequently called inline function,
and there is only one single call with a user-space value, it's better
to open-code it locally with array_index_nospec() hardening.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_hwdep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 57df06e76968..cc009a4a3d1d 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -51,7 +52,16 @@ static int get_wcap_ioctl(struct hda_codec *codec,
 	
 	if (get_user(verb, &arg->verb))
 		return -EFAULT;
-	res = get_wcaps(codec, verb >> 24);
+	/* open-code get_wcaps(verb>>24) with nospec */
+	verb >>= 24;
+	if (verb < codec->core.start_nid ||
+	    verb >= codec->core.start_nid + codec->core.num_nodes) {
+		res = 0;
+	} else {
+		verb -= codec->core.start_nid;
+		verb = array_index_nospec(verb, codec->core.num_nodes);
+		res = codec->wcaps[verb];
+	}
 	if (put_user(res, &arg->res))
 		return -EFAULT;
 	return 0;
-- 
2.16.3
