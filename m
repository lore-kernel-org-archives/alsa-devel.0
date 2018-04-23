From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix forgotten conversion of
	control query functions
Date: Mon, 23 Apr 2018 09:06:34 +0200
Message-ID: <20180423070634.10758-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F2122671EA
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 09:06:42 +0200 (CEST)
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
Cc: Andrew Chant <achant@google.com>, Nazar Mokrynskyi <nazar@mokrynskyi.com>
List-Id: alsa-devel@alsa-project.org

The recent code refactoring made the argument for some helper
functions to be the explicit UAC_CS_* and UAC2_CS_* value instead of
0-based offset.  However, there was one place left forgotten, and it
caused a regression on some devices appearing as the inconsistent
mixer setup.

This patch corrects the forgotten conversion.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199449
Fixes: 21e9b3e931f7 ("ALSA: usb-audio: fix uac control query argument")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61ed426..3387483310b1 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1776,7 +1776,8 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 				build_feature_ctl(state, _ftr, ch_bits, control,
 						  &iterm, unitid, ch_read_only);
 			if (uac_v2v3_control_is_readable(master_bits, control))
-				build_feature_ctl(state, _ftr, 0, i, &iterm, unitid,
+				build_feature_ctl(state, _ftr, 0, control,
+						  &iterm, unitid,
 						  !uac_v2v3_control_is_writeable(master_bits,
 										 control));
 		}
-- 
2.16.3
