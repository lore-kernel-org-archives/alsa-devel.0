From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] pcm/kernel: Add DSD formats silence patterns
Date: Sun, 24 Aug 2014 10:04:08 +0200
Message-ID: <1408867448-13373-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B382619F2
 for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2014 10:04:14 +0200 (CEST)
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

This patch adds the silence patterns for the DSD sample formats, kernel side.

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/core/pcm_misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 4560ca0..2c6fd80 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -142,11 +142,11 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 	},
 	[SNDRV_PCM_FORMAT_DSD_U8] = {
 		.width = 8, .phys = 8, .le = 1, .signd = 0,
-		.silence = {},
+		.silence = { 0x69 },
 	},
 	[SNDRV_PCM_FORMAT_DSD_U16_LE] = {
 		.width = 16, .phys = 16, .le = 1, .signd = 0,
-		.silence = {},
+		.silence = { 0x69, 0x69 },
 	},
 	/* FIXME: the following three formats are not defined properly yet */
 	[SNDRV_PCM_FORMAT_MPEG] = {
-- 
1.9.3
