From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: bcd2000: Make local data static
Date: Tue, 26 May 2015 14:41:51 +0200
Message-ID: <1432644112-16543-5-git-send-email-tiwai@suse.de>
References: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DFB26520E
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:54 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CA111AD8C
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
In-Reply-To: <1432644112-16543-1-git-send-email-tiwai@suse.de>
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

Spotted by sparse:
  sound/usb/bcd2000/bcd2000.c:73:1: warning: symbol 'devices_used' was not declared. Should it be static?

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/bcd2000/bcd2000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 820d6ca8c458..d060dddcc52d 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -70,7 +70,7 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 
 static DEFINE_MUTEX(devices_mutex);
-DECLARE_BITMAP(devices_used, SNDRV_CARDS);
+static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 static struct usb_driver bcd2000_driver;
 
 #ifdef CONFIG_SND_DEBUG
-- 
2.4.1
