From: idak <zbe64533@gmail.com>
Subject: [PATCH] Fix "alc262_sony_unsol[]" hda_verb array
Date: Mon, 9 Jun 2008 22:46:07 +0900
Message-ID: <aeb93b2b0806090646l1585adbfwf3cd701d7a15944e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 01014249E4
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 15:46:08 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3054741wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2008 06:46:07 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

I think that hda_verb array must have "terminator (empty array)".
But alc262_sony_unsol[] does not have it.
And it causes gcc-4.3's buggy behavior
with snd_hda_sequence_write().

Signed-off-by: Akio Idehara <zbe64533@gmail.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)
--- a/sound/pci/hda/patch_realtek.c	2008-06-08 19:23:57.000000000 +0900
+++ b/sound/pci/hda/patch_realtek.c	2008-06-08 19:42:19.000000000 +0900
@@ -8839,6 +8839,7 @@ static struct hda_verb alc262_sony_unsol

 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{}
 };

 /* mute/unmute internal speaker according to the hp jack and mute state */
