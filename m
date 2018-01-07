From: "Arkadiusz (Arkq) Bokowy" <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 3/3] plugio: Check for pointer callback error
	codes
Date: Sun, 7 Jan 2018 14:32:14 +0100
Message-ID: <20180107143214.6d31af53@sambook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 143E2266AE1
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 14:33:13 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id y71so9490286lfd.12
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 05:33:13 -0800 (PST)
Received: from sambook (89-73-142-93.dynamic.chello.pl. [89.73.142.93])
 by smtp.gmail.com with ESMTPSA id f73sm1764330lfg.93.2018.01.07.05.33.12
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 Jan 2018 05:33:12 -0800 (PST)
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

plugio: Check for pointer callback error codes

By checking error code returned by the pointer callback, we can
determine more precisely PCM state. Previous implementation assumed,
that a software PCM can only produce overrun or underrun. It was
impossible to mark software PCM as disconnected.

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 src/pcm/pcm_ioplug.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 06c20d7b..cc234611 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -53,20 +53,29 @@ static int snd_pcm_ioplug_hw_ptr_update(snd_pcm_t
*pcm) {
 	ioplug_priv_t *io = pcm->private_data;
 	snd_pcm_sframes_t hw;
+	unsigned int delta;
 
 	hw = io->data->callback->pointer(io->data);
-	if (hw >= 0) {
-		unsigned int delta;
-		if ((unsigned int)hw >= io->last_hw)
-			delta = hw - io->last_hw;
-		else
-			delta = pcm->buffer_size + hw - io->last_hw;
-		snd_pcm_mmap_hw_forward(io->data->pcm, delta);
-		io->last_hw = hw;
-		return 0;
-	} else
-		io->data->state = SNDRV_PCM_STATE_XRUN;
-		return -EPIPE;
+	if (hw < 0) {
+		switch (hw) {
+		case -ESTRPIPE:
+			io->data->state = SND_PCM_STATE_SUSPENDED;
+			break;
+		case -ENODEV:
+			io->data->state = SND_PCM_STATE_DISCONNECTED;
+			break;
+		default:
+			io->data->state = SND_PCM_STATE_XRUN;
+		}
+		return hw;
+	}
+	if ((unsigned int)hw >= io->last_hw)
+		delta = hw - io->last_hw;
+	else
+		delta = pcm->buffer_size + hw - io->last_hw;
+	snd_pcm_mmap_hw_forward(io->data->pcm, delta);
+	io->last_hw = hw;
+	return 0;
 }
 
 static int snd_pcm_ioplug_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
-- 
2.13.6
