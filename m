From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 4/4] pcm: null: add rewindable and forwardable
	callbacks
Date: Thu, 12 Jun 2014 16:34:24 +0600
Message-ID: <1402569264-2789-5-git-send-email-patrakov@gmail.com>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 536F1265204
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 12:34:48 +0200 (CEST)
Received: by mail-lb0-f176.google.com with SMTP id p9so555731lbv.7
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 03:34:48 -0700 (PDT)
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

Dirty, but consistent with avail_update.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_null.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index a154a5c..f1d2f91 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -168,6 +168,17 @@ static int snd_pcm_null_pause(snd_pcm_t *pcm, int enable)
 	return 0;
 }
 
+static snd_pcm_sframes_t snd_pcm_null_rewindable(snd_pcm_t *pcm)
+{
+	return pcm->buffer_size;
+}
+
+static snd_pcm_sframes_t snd_pcm_null_forwardable(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+{
+	return 0;
+}
+
+
 static snd_pcm_sframes_t snd_pcm_null_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_null_t *null = pcm->private_data;
@@ -325,7 +336,9 @@ static const snd_pcm_fast_ops_t snd_pcm_null_fast_ops = {
 	.drop = snd_pcm_null_drop,
 	.drain = snd_pcm_null_drain,
 	.pause = snd_pcm_null_pause,
+	.rewindable = snd_pcm_null_rewindable,
 	.rewind = snd_pcm_null_rewind,
+	.forwardable = snd_pcm_null_forwardable,
 	.forward = snd_pcm_null_forward,
 	.resume = snd_pcm_null_resume,
 	.writei = snd_pcm_null_writei,
-- 
2.0.0
