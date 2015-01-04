From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/13] ALSA: seq: Deletion of unnecessary checks before the
 function call "snd_midi_event_free"
Date: Sun, 04 Jan 2015 13:50:10 +0100
Message-ID: <54A93702.4040705@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net> <54A9355F.4050102@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54A9355F.4050102@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jan 2015 14:54:56 +0100

The snd_midi_event_free() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/seq/oss/seq_oss_midi.c | 6 ++----
 sound/core/seq/seq_midi.c         | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index 3a45696..e79cc44 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -237,8 +237,7 @@ snd_seq_oss_midi_check_exit_port(int client, int port)
 		spin_unlock_irqrestore(&register_lock, flags);
 		snd_use_lock_free(&mdev->use_lock);
 		snd_use_lock_sync(&mdev->use_lock);
-		if (mdev->coder)
-			snd_midi_event_free(mdev->coder);
+		snd_midi_event_free(mdev->coder);
 		kfree(mdev);
 	}
 	spin_lock_irqsave(&register_lock, flags);
@@ -265,8 +264,7 @@ snd_seq_oss_midi_clear_all(void)
 	spin_lock_irqsave(&register_lock, flags);
 	for (i = 0; i < max_midi_devs; i++) {
 		if ((mdev = midi_devs[i]) != NULL) {
-			if (mdev->coder)
-				snd_midi_event_free(mdev->coder);
+			snd_midi_event_free(mdev->coder);
 			kfree(mdev);
 			midi_devs[i] = NULL;
 		}
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index a1fd77a..68fec77 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -268,8 +268,7 @@ static void snd_seq_midisynth_delete(struct seq_midisynth *msynth)
 		snd_seq_event_port_detach(msynth->seq_client, msynth->seq_port);
 	}
 
-	if (msynth->parser)
-		snd_midi_event_free(msynth->parser);
+	snd_midi_event_free(msynth->parser);
 }
 
 /* register new midi synth port */
-- 
2.2.1
