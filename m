From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/15] ALSA: firewire-lib: move PCM substream
	constraint to AM824 layer
Date: Sat, 19 Sep 2015 11:21:57 +0900
Message-ID: <1442629322-15457-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 148612604FA
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, PCM frames are transferred in Multi Bit Linear Audio data
channel. The data channel transfers 16/20/24 bit PCM samples. Thus, PCM
substream has a constrain about it.

This commit moves codes related to the constraint from packet streaming
layer to AM824 data block processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c             | 20 ++++++++++++++++++++
 sound/firewire/amdtp-am824.h             |  5 +++++
 sound/firewire/amdtp-stream.c            |  5 -----
 sound/firewire/bebob/bebob_pcm.c         |  2 +-
 sound/firewire/dice/dice-pcm.c           |  2 +-
 sound/firewire/fireworks/fireworks_pcm.c |  2 +-
 sound/firewire/oxfw/oxfw-pcm.c           |  2 +-
 7 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index f5edcbf..7adaba3 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -53,6 +53,26 @@ int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 EXPORT_SYMBOL_GPL(amdtp_am824_set_parameters);
 
 /**
+ * amdtp_am824_add_pcm_hw_constraints - add hw constraints for PCM substream
+ * @s:		the AMDTP stream for AM824 data block, must be initialized.
+ * @runtime:	the PCM substream runtime
+ *
+ */
+int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
+				       struct snd_pcm_runtime *runtime)
+{
+	int err;
+
+	err = amdtp_stream_add_pcm_hw_constraints(s, runtime);
+	if (err < 0)
+		return err;
+
+	/* AM824 in IEC 61883-6 can deliver 24bit data. */
+	return snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_add_pcm_hw_constraints);
+
+/**
  * amdtp_am824_init - initialize an AMDTP stream structure to handle AM824
  *		      data block
  * @s: the AMDTP stream to initialize
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index cfc0d61..4aaed90 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -1,6 +1,8 @@
 #ifndef SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
 #define SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
 
+#include <sound/pcm.h>
+
 #include "amdtp-stream.h"
 
 int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
@@ -8,6 +10,9 @@ int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 			       unsigned int midi_ports,
 			       bool double_pcm_frames);
 
+int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
+				       struct snd_pcm_runtime *runtime);
+
 int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
 		     enum amdtp_stream_direction dir, enum cip_flags flags);
 #endif
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 39ad8e8..06fbf23 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -140,11 +140,6 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 {
 	int err;
 
-	/* AM824 in IEC 61883-6 can deliver 24bit data */
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
-	if (err < 0)
-		goto end;
-
 	/*
 	 * Currently firewire-lib processes 16 packets in one software
 	 * interrupt callback. This equals to 2msec but actually the
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index c0f018a..50610ca 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -146,7 +146,7 @@ pcm_init_hw_params(struct snd_bebob *bebob,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(s, runtime);
+	err = amdtp_am824_add_pcm_hw_constraints(s, runtime);
 end:
 	return err;
 }
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 4e67b1d..f5f3007 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -156,7 +156,7 @@ static int init_hw_info(struct snd_dice *dice,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(stream, runtime);
+	err = amdtp_am824_add_pcm_hw_constraints(stream, runtime);
 end:
 	return err;
 }
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index c30b2ff..f186ab7 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -187,7 +187,7 @@ pcm_init_hw_params(struct snd_efw *efw,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(s, runtime);
+	err = amdtp_am824_add_pcm_hw_constraints(s, runtime);
 end:
 	return err;
 }
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 9c73930..bddd287 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -158,7 +158,7 @@ static int init_hw_params(struct snd_oxfw *oxfw,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_add_pcm_hw_constraints(stream, runtime);
+	err = amdtp_am824_add_pcm_hw_constraints(stream, runtime);
 end:
 	return err;
 }
-- 
2.1.4
