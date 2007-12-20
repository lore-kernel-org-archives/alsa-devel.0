From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] fix entries for U24_BE and U24_LE in
	pcm_formats[] array
Date: Thu, 20 Dec 2007 14:43:14 -0600
Message-ID: <11981833941205-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 37A43103889
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 21:43:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

SNDRV_PCM_FORMAT_U24_BE and SNDRV_PCM_FORMAT_U24_LE represent 24-bit samples
that are aligned into a 4-byte word, so the most significant byte is always
zero.  The entries for these two sample formats in the pcm_formats[] array
only specified 3 bytes.  For SNDRV_PCM_FORMAT_U24_LE, the compiler
automatically adds the 4th byte, but for SNDRV_PCM_FORMAT_U24_BE the entry
was just wrong.  This patch fixes both entries.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

I do not have hardware that supports U24_BE, so I can't test this change.

 sound/core/pcm_misc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index dd9aa51..077fc0b 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -71,11 +71,11 @@ static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
 	},
 	[SNDRV_PCM_FORMAT_U24_LE] = {
 		.width = 24, .phys = 32, .le = 1, .signd = 0,
-		.silence = { 0x00, 0x00, 0x80 },
+		.silence = { 0x00, 0x00, 0x80, 0x00 },
 	},
 	[SNDRV_PCM_FORMAT_U24_BE] = {
 		.width = 24, .phys = 32, .le = 0, .signd = 0,
-		.silence = { 0x80, 0x00, 0x00 },
+		.silence = { 0x00, 0x80, 0x00, 0x00 },
 	},
 	[SNDRV_PCM_FORMAT_S32_LE] = {
 		.width = 32, .phys = 32, .le = 1, .signd = 1,
-- 
1.5.2.4
