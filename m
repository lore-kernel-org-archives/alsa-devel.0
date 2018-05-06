From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] ASoC: omap-pcm: Use 'snd_pcm_format_t' type
Date: Sun,  6 May 2018 12:47:45 -0300
Message-ID: <1525621665-11022-3-git-send-email-festevam@gmail.com>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 22751267345
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 17:47:54 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id q6-v6so33318426qtn.3
 for <alsa-devel@alsa-project.org>; Sun, 06 May 2018 08:47:54 -0700 (PDT)
In-Reply-To: <1525621665-11022-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

'snd_pcm_format_t' type is better suited for iterating through the
SNDRV_PCM_FORMAT members.

Also, use SNDRV_PCM_FORMAT_FIRST for the first element.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/omap/omap-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 778cc8f..d1b07e4 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -56,9 +56,9 @@ static struct snd_pcm_hardware omap_pcm_hardware = {
 /* sDMA supports only 1, 2, and 4 byte transfer elements. */
 static void omap_pcm_limit_supported_formats(void)
 {
-	int i;
+	snd_pcm_format_t i;
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		switch (snd_pcm_format_physical_width(i)) {
 		case 8:
 		case 16:
-- 
2.7.4
