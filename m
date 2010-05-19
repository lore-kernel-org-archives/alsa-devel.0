From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: usb/mixer.c: remove unused variable
Date: Wed, 19 May 2010 17:34:45 +0200
Message-ID: <1274283285-14250-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3736410395C
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 17:35:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This was a development left-over.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/mixer.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index fd3e08d..a35dd74 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1970,8 +1970,6 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 				       int attribute, int value, int index)
 {
-	struct usb_mixer_elem_info *info;
-
 	switch (attribute) {
 	case UAC2_CS_CUR:
 		snd_usb_mixer_notify_id(mixer, index);
-- 
1.7.1
