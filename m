From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: usb-audio: fix msleep timeout due to
	minimum resolution of task scheduling
Date: Tue, 21 Feb 2017 05:09:21 +0900
Message-ID: <20170220200921.824-6-o-takashi@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 829F5266B39
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:09:31 +0100 (CET)
In-Reply-To: <20170220200921.824-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: onkel@paraair.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Depending on tick-related kernel configuration; e.g. HZ, task scheduler
necessarily has no guarantee for its minimum resolution against ~20 msec
msleep timeout.

This commit expands msleep timeout up to 20 msec with an optimistic view
to packet handling capability of the target device. 'checkpatch.pl'
generated below warning.

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+		msleep(15);

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index d34dd1c..1c2d167 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -548,7 +548,7 @@ static int snd_us16x08_eqswitch_put(struct snd_kcontrol *kcontrol,
 		if (err < 0)
 			break;
 		store->val[b_idx][3][index] = val;
-		msleep(15);
+		msleep(20);
 	}
 
 	if (err > 0) {
-- 
2.9.3
