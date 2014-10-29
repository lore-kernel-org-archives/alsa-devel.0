From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: doc: Fix enum snd_jack_types comments
Date: Wed, 29 Oct 2014 08:26:07 +0100
Message-ID: <1414567569-11722-2-git-send-email-tiwai@suse.de>
References: <1414567569-11722-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF56260435
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 08:26:14 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F1E3EAD91
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:26:13 +0000 (UTC)
In-Reply-To: <1414567569-11722-1-git-send-email-tiwai@suse.de>
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

Follow the proper kerneldoc rule, and complete enum item comments.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/jack.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 37e612e77410..67f2bbcd515e 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -28,7 +28,21 @@
 struct input_dev;
 
 /**
- * enum snd_jack_types: Jack types which can be reported
+ * enum snd_jack_types - Jack types which can be reported
+ * @SND_JACK_HEADPHONE: Headphone
+ * @SND_JACK_MICROPHONE: Microphone
+ * @SND_JACK_HEADSET: Headset
+ * @SND_JACK_LINEOUT: Line out
+ * @SND_JACK_MECHANICAL: Mechanical switch
+ * @SND_JACK_VIDEOOUT: Video out
+ * @SND_JACK_AVOUT: AV (Audio Video) out
+ * @SND_JACK_LINEIN:  Line in
+ * @SND_JACK_BTN_0: Button 0
+ * @SND_JACK_BTN_1: Button 1
+ * @SND_JACK_BTN_2: Button 2
+ * @SND_JACK_BTN_3: Button 3
+ * @SND_JACK_BTN_4: Button 4
+ * @SND_JACK_BTN_5: Button 5
  *
  * These values are used as a bitmask.
  *
-- 
2.1.2
