From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 9/9] ALSA: usb-audio: WARN_ON when alts is
	passed as NULL
Date: Sat,  3 Aug 2013 10:51:15 +0200
Message-ID: <1375519875-25774-3-git-send-email-eldad@fogrefinery.com>
References: <1375519875-25774-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 304F3261A22
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:51:30 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so450259bkh.40
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:51:30 -0700 (PDT)
In-Reply-To: <1375519875-25774-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Prevent NULL dereference in snd_usb_add_endpoints(), when
alts is passed as NULL. In this case, WARN (since this is
a non-fatal bug) and return NULL ep. Call sites treat a NULL
return value as an error.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 7a444b5..92ea945 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -418,6 +418,9 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 	struct snd_usb_endpoint *ep;
 	int is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
 
+	if (WARN_ON(!alts))
+		return NULL;
+
 	mutex_lock(&chip->mutex);
 
 	list_for_each_entry(ep, &chip->ep_list, list) {
-- 
1.8.1.5
