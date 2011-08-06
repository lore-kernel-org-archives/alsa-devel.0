From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb-caiaq: Fix keymap for RigKontrol3
Date: Sat,  6 Aug 2011 09:13:08 +0200
Message-ID: <1312614788-29379-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id E03342451D
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Aug 2011 09:13:28 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, stable@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Renato <naretobh@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: stable@kernel.org
---
 sound/usb/caiaq/input.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 4432ef7..a213813 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -30,7 +30,7 @@ static unsigned short keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
 static unsigned short keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
 					 KEY_5, KEY_6, KEY_7 };
 static unsigned short keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
-					 KEY_5, KEY_6, KEY_7, KEY_5, KEY_6 };
+					 KEY_5, KEY_6, KEY_7, KEY_8, KEY_9 };
 
 static unsigned short keycode_kore[] = {
 	KEY_FN_F1,      /* "menu"               */
-- 
1.7.6
