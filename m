From: Yao-Wen Mao <yaowen@google.com>
Subject: [PATCH] ALSA: usb-audio: correct the value cache check.
Date: Fri, 28 Aug 2015 16:33:25 +0800
Message-ID: <1440750805-147304-1-git-send-email-yaowen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0227A2602F1
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 10:33:31 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so18818955pac.3
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 01:33:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc: dgreid@chromium.org, Yao-Wen Mao <yaowen@google.com>
List-Id: alsa-devel@alsa-project.org

The check of cval->cached should be zero-based (including master channel).

Signed-off-by: Yao-Wen Mao <yaowen@google.com>
---
 sound/usb/mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index fd5c49e..f494dce 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2540,7 +2540,7 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 		for (c = 0; c < MAX_CHANNELS; c++) {
 			if (!(cval->cmask & (1 << c)))
 				continue;
-			if (cval->cached & (1 << c)) {
+			if (cval->cached & (1 << (c + 1))) {
 				err = snd_usb_set_cur_mix_value(cval, c + 1, idx,
 							cval->cache_val[idx]);
 				if (err < 0)
-- 
2.5.0.457.gab17608
