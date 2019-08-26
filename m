From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: usb-audio: remove some dead code
Date: Mon, 26 Aug 2019 16:45:50 +0300
Message-ID: <20190826134550.GA8842@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1F80F801ED
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 15:46:00 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Richard Fontana <rfontana@redhat.com>, alsa-devel@alsa-project.org, Hui Peng <benquike@gmail.com>, kernel-janitors@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
List-Id: alsa-devel@alsa-project.org

We recently cleaned up the error handling in commit 52c3e317a857 ("ALSA:
usb-audio: Unify the release of usb_mixer_elem_info objects") but
accidentally left this stray return.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/usb/mixer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a0468c4a6326..a607577f0097 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2633,7 +2633,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		err = -ENOMEM;
 		goto error_name;
-		return -ENOMEM;
 	}
 	kctl->private_value = (unsigned long)namelist;
 	kctl->private_free = usb_mixer_selector_elem_free;
-- 
2.20.1
