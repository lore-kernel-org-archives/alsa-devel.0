From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 2/4] pcm: rate: add rewindable and forwardable
	callbacks
Date: Thu, 12 Jun 2014 16:34:22 +0600
Message-ID: <1402569264-2789-3-git-send-email-patrakov@gmail.com>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C052650EE
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 12:34:45 +0200 (CEST)
Received: by mail-lb0-f181.google.com with SMTP id q8so556306lbi.26
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 03:34:45 -0700 (PDT)
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

This commit does not fix nonsense values returned by the rewind and
forward callbacks. E.g., with period_size = 1024 and buffer_size = 4096,
an attempt to rewind 1024 samples from the nearly-full buffer returns
4090.

Due to these nonsense values, the current rate plugin should be treated
as non-rewindable. That's why the new callbacks return 0.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_rate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 2eb4b1b..58ed842 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -689,6 +689,16 @@ static int snd_pcm_rate_reset(snd_pcm_t *pcm)
 	return 0;
 }
 
+static snd_pcm_sframes_t snd_pcm_rate_rewindable(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+{
+	return 0;
+}
+
+static snd_pcm_sframes_t snd_pcm_rate_forwardable(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+{
+	return 0;
+}
+
 static snd_pcm_sframes_t snd_pcm_rate_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
@@ -1221,7 +1231,9 @@ static const snd_pcm_fast_ops_t snd_pcm_rate_fast_ops = {
 	.drop = snd_pcm_generic_drop,
 	.drain = snd_pcm_rate_drain,
 	.pause = snd_pcm_generic_pause,
+	.rewindable = snd_pcm_rate_rewindable,
 	.rewind = snd_pcm_rate_rewind,
+	.forwardable = snd_pcm_rate_forwardable,
 	.forward = snd_pcm_rate_forward,
 	.resume = snd_pcm_generic_resume,
 	.writei = snd_pcm_mmap_writei,
-- 
2.0.0
