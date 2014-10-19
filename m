From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ALSA: snd-usb: use strncpy() in
	mixer_quirks.c
Date: Sun, 19 Oct 2014 09:11:26 +0200
Message-ID: <1413702686-8751-2-git-send-email-daniel@zonque.org>
References: <1413702686-8751-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D30A2604FD
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 09:11:36 +0200 (CEST)
In-Reply-To: <1413702686-8751-1-git-send-email-daniel@zonque.org>
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
Cc: tiwai@suse.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Out of principles, use strncpy() in favor of strcpy().
That is, however, an insignificant detail here.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/mixer_quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f119a41..f406305 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -446,8 +446,9 @@ static int snd_emu0204_ch_switch_info(struct snd_kcontrol *kcontrol,
 	uinfo->value.enumerated.items = 2;
 	if (uinfo->value.enumerated.item > 1)
 		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
+	strncpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item],
+		sizeof(uinfo->value.enumerated.name) - 1);
 
 	return 0;
 }
-- 
2.1.0
