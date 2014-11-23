From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] amixer: Make "dB" case-insensitive in set
	commands
Date: Sun, 23 Nov 2014 10:16:01 +0100
Message-ID: <1416734162-24748-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 40B0A2605A6
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 10:16:04 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 00F42AB07
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 09:16:03 +0000 (UTC)
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

We don't have to be necessarily too strict about case-sensitivity of
"dB" suffix used in set commands.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 amixer/amixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index cf82892bfa2f..6a2fdb96c62f 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -346,7 +346,7 @@ static int set_volume_simple(snd_mixer_elem_t *elem,
 	if (*p == '%') {
 		percent = 1;
 		p++;
-	} else if (p[0] == 'd' && p[1] == 'B') {
+	} else if (toupper(p[0]) == 'D' && toupper(p[1]) == 'B') {
 		vol_type = VOL_DB;
 		p += 2;
 		scale = 100;
-- 
2.1.3
