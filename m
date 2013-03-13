From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: info: Small refactoring and a sanity
	check in snd_info_get_line()
Date: Wed, 13 Mar 2013 17:36:40 +0100
Message-ID: <1363192600-11832-2-git-send-email-tiwai@suse.de>
References: <1363192600-11832-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FFD42617AF
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:36:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 486FEA4E82
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:36:40 +0100 (CET)
In-Reply-To: <1363192600-11832-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 58e97b3..c9042b4 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -700,26 +700,21 @@ int snd_info_get_line(struct snd_info_buffer *buffer, char *line, int len)
 {
 	int c = -1;
 
+	if (snd_BUG_ON(!buffer || !buffer->buffer))
+		return 1;
 	if (len <= 0 || buffer->stop || buffer->error)
 		return 1;
-	while (--len > 0) {
+	while (!buffer->stop) {
 		c = buffer->buffer[buffer->curr++];
-		if (c == '\n') {
-			if (buffer->curr >= buffer->size)
-				buffer->stop = 1;
-			break;
-		}
-		*line++ = c;
-		if (buffer->curr >= buffer->size) {
+		if (buffer->curr >= buffer->size)
 			buffer->stop = 1;
+		if (c == '\n')
 			break;
+		if (len) {
+			len--;
+			*line++ = c;
 		}
 	}
-	while (c != '\n' && !buffer->stop) {
-		c = buffer->buffer[buffer->curr++];
-		if (buffer->curr >= buffer->size)
-			buffer->stop = 1;
-	}
 	*line = '\0';
 	return 0;
 }
-- 
1.8.1.4
