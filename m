From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: rawmidi: Add const to snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:36 +0100
Message-ID: <20170111190242.12585-2-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 553C026752C
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:44 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C72D4AB49
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 19:02:43 +0000 (UTC)
In-Reply-To: <20170111190242.12585-1-tiwai@suse.de>
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

Make snd_rawmidi_substream.ops to be a const pointer to be safer and
allow more optimization.  The patches to constify each rawmidi ops
will follow.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h | 4 ++--
 sound/core/rawmidi.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index f730b91e472f..492a3ca7f17b 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -103,7 +103,7 @@ struct snd_rawmidi_substream {
 	struct snd_rawmidi_runtime *runtime;
 	struct pid *pid;
 	/* hardware layer */
-	struct snd_rawmidi_ops *ops;
+	const struct snd_rawmidi_ops *ops;
 };
 
 struct snd_rawmidi_file {
@@ -155,7 +155,7 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 		    int output_count, int input_count,
 		    struct snd_rawmidi **rmidi);
 void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
-			 struct snd_rawmidi_ops *ops);
+			 const struct snd_rawmidi_ops *ops);
 
 /* callbacks */
 
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 2096bb0835c8..8da9cb245d01 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1749,7 +1749,7 @@ static int snd_rawmidi_dev_disconnect(struct snd_device *device)
  * Sets the rawmidi operators for the given stream direction.
  */
 void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
-			 struct snd_rawmidi_ops *ops)
+			 const struct snd_rawmidi_ops *ops)
 {
 	struct snd_rawmidi_substream *substream;
 	
-- 
2.11.0
