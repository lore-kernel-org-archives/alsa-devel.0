From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 1/5] ALSA: Add jack types to dt-bindings
Date: Fri, 22 May 2015 15:09:19 -0700
Message-ID: <1432332563-15447-2-git-send-email-dgreid@chromium.org>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f202.google.com (mail-ig0-f202.google.com
 [209.85.213.202])
 by alsa0.perex.cz (Postfix) with ESMTP id B7BA4260425
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:55 +0200 (CEST)
Received: by igdh15 with SMTP id h15so100964igd.0
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:54 -0700 (PDT)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
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
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Adding the jack type to the dt-bindings directory will allow for device
tree files to specify the type of audio jacks that are present for a
board.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 include/dt-bindings/sound/audio-jack-events.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/dt-bindings/sound/audio-jack-events.h

diff --git a/include/dt-bindings/sound/audio-jack-events.h b/include/dt-bindings/sound/audio-jack-events.h
new file mode 100644
index 0000000..378349f
--- /dev/null
+++ b/include/dt-bindings/sound/audio-jack-events.h
@@ -0,0 +1,9 @@
+#ifndef __AUDIO_JACK_EVENTS_H
+#define __AUDIO_JACK_EVENTS_H
+
+#define JACK_HEADPHONE		1
+#define JACK_MICROPHONE		2
+#define JACK_LINEOUT		3
+#define JACK_LINEIN		4
+
+#endif /* __AUDIO_JACK_EVENTS_H */
-- 
2.2.1.62.g3f15098
