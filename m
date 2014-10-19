From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] ALSA: snd-usb: drop unused varible
	assigments
Date: Sun, 19 Oct 2014 09:11:25 +0200
Message-ID: <1413702686-8751-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A381F2604F4
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 09:11:35 +0200 (CEST)
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

Don't assign 'len' in cases where we don't make use of the returned value.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/mixer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2e4a9db..63a8adb 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1290,9 +1290,8 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 						    kctl->id.name,
 						    sizeof(kctl->id.name), 1);
 			if (!len)
-				len = snprintf(kctl->id.name,
-					       sizeof(kctl->id.name),
-					       "Feature %d", unitid);
+				snprintf(kctl->id.name, sizeof(kctl->id.name),
+					 "Feature %d", unitid);
 		}
 
 		if (!mapped_name)
@@ -1305,9 +1304,9 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		 */
 		if (!mapped_name && !(state->oterm.type >> 16)) {
 			if ((state->oterm.type & 0xff00) == 0x0100)
-				len = append_ctl_name(kctl, " Capture");
+				append_ctl_name(kctl, " Capture");
 			else
-				len = append_ctl_name(kctl, " Playback");
+				append_ctl_name(kctl, " Playback");
 		}
 		append_ctl_name(kctl, control == UAC_FU_MUTE ?
 				" Switch" : " Volume");
-- 
2.1.0
