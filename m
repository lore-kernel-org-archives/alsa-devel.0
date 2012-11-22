From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: properly initialize the sync
	endpoint
Date: Thu, 22 Nov 2012 20:27:59 +0100
Message-ID: <1353612479-8460-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C1DC260376
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 20:28:15 +0100 (CET)
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
Cc: tiwai@suse.de, stable@kernel.org, "[3.5+]"@mail.zonque.de, jeff_barish@earthlink.net, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Jeffrey Barish reported an obvious bug in the pcm part of the usb-audio
driver which causes the code to not initialize the sync endpoint from
configure_endpoint().

Reported-by: Jeffrey Barish <jeff_barish@earthlink.net>
Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: stable@kernel.org [3.5+]
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index bc3c9ac..e919c2e 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -458,7 +458,7 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 		return ret;
 
 	if (subs->sync_endpoint)
-		ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+		ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
 						  subs->pcm_format,
 						  subs->channels,
 						  subs->period_bytes,
-- 
1.7.11.7
