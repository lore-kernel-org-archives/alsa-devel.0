From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-lib)] chmap: Always succeed setting the
	map to what it already is
Date: Wed,  5 Jun 2013 16:52:10 +0200
Message-ID: <1370443930-8244-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F08312654AC
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:52:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If we try to set the channel map to what it already is, this should
always succeed. E g, speaker-test can do this sometimes.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 7ec1f0e..ca4d416 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7361,6 +7361,13 @@ OBSOLETE1(snd_pcm_sw_params_get_silence_size, ALSA_0.9, ALSA_0.9.0rc4);
 
 #endif /* DOC_HIDDEN */
 
+static int chmap_equal(const snd_pcm_chmap_t *a, const snd_pcm_chmap_t *b)
+{
+	if (a->channels != b->channels)
+		return 0;
+	return !memcmp(a->pos, b->pos, a->channels * sizeof(a->pos[0]));
+}
+
 /**
  * \!brief Query the available channel maps
  * \param pcm PCM handle to query
@@ -7415,6 +7422,10 @@ snd_pcm_chmap_t *snd_pcm_get_chmap(snd_pcm_t *pcm)
  */
 int snd_pcm_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map)
 {
+	const snd_pcm_chmap_t *oldmap = snd_pcm_get_chmap(pcm);
+	if (oldmap && chmap_equal(oldmap, map))
+		return 0;
+
 	if (!pcm->ops->set_chmap)
 		return -ENXIO;
 	return pcm->ops->set_chmap(pcm, map);
-- 
1.7.9.5
