From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] pcm: 2nd round of pcm_misc DSD fixes
Date: Fri, 15 Aug 2014 08:43:39 +0200
Message-ID: <1408085019-5277-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb1-smtp-cloud2.xs4all.net (lb1-smtp-cloud2.xs4all.net
 [194.109.24.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A2F26501D
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 08:43:47 +0200 (CEST)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Functions 'snd_pcm_format_silence_64' and 'snd_pcm_format_size' also need to be
able to handle the DSD formats.

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 src/pcm/pcm_misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index 24d52f9..c52e7bf 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -317,11 +317,13 @@ ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S8:
 	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_DSD_U8:
 		return samples;
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_S16_BE:
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return samples * 2;
 	case SNDRV_PCM_FORMAT_S18_3LE:
 	case SNDRV_PCM_FORMAT_S18_3BE:
@@ -387,6 +389,8 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_S20_3BE:
 	case SNDRV_PCM_FORMAT_S18_3LE:
 	case SNDRV_PCM_FORMAT_S18_3BE:
+	case SNDRV_PCM_FORMAT_DSD_U8:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return 0;
 	case SNDRV_PCM_FORMAT_U8:
 		return 0x8080808080808080ULL;
-- 
1.9.3
