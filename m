From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 3/4] pcm: multi: implement rewindable and
	forwardable callbacks
Date: Thu, 12 Jun 2014 16:34:23 +0600
Message-ID: <1402569264-2789-4-git-send-email-patrakov@gmail.com>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 821382651B2
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 12:34:47 +0200 (CEST)
Received: by mail-la0-f50.google.com with SMTP id b8so565570lan.23
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 03:34:46 -0700 (PDT)
In-Reply-To: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
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
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_multi.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index f58852c..a84e0ce 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -555,6 +555,42 @@ static int snd_pcm_multi_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *in
 	return err;
 }
 
+static snd_pcm_sframes_t snd_pcm_multi_rewindable(snd_pcm_t *pcm)
+{
+	snd_pcm_multi_t *multi = pcm->private_data;
+	unsigned int i;
+	snd_pcm_sframes_t frames = LONG_MAX;
+
+	for (i = 0; i < multi->slaves_count; ++i) {
+		snd_pcm_sframes_t f = snd_pcm_rewindable(multi->slaves[i].pcm);
+		if (f <= 0)
+			return f;
+		if (f < frames)
+			frames = f;
+	}
+
+	return frames;
+
+}
+
+static snd_pcm_sframes_t snd_pcm_multi_forwardable(snd_pcm_t *pcm)
+{
+	snd_pcm_multi_t *multi = pcm->private_data;
+	unsigned int i;
+	snd_pcm_sframes_t frames = LONG_MAX;
+
+	for (i = 0; i < multi->slaves_count; ++i) {
+		snd_pcm_sframes_t f = snd_pcm_forwardable(multi->slaves[i].pcm);
+		if (f <= 0)
+			return f;
+		if (f < frames)
+			frames = f;
+	}
+
+	return frames;
+
+}
+
 static snd_pcm_sframes_t snd_pcm_multi_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_multi_t *multi = pcm->private_data;
@@ -932,7 +968,9 @@ static const snd_pcm_fast_ops_t snd_pcm_multi_fast_ops = {
 	.writen = snd_pcm_mmap_writen,
 	.readi = snd_pcm_mmap_readi,
 	.readn = snd_pcm_mmap_readn,
+	.rewindable = snd_pcm_multi_rewindable,
 	.rewind = snd_pcm_multi_rewind,
+	.forwardable = snd_pcm_multi_forwardable,
 	.forward = snd_pcm_multi_forward,
 	.resume = snd_pcm_multi_resume,
 	.link = snd_pcm_multi_link,
-- 
2.0.0
