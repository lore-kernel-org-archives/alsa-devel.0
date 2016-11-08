From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: info: Limit the proc text input size
Date: Tue,  8 Nov 2016 15:18:55 +0100
Message-ID: <20161108141856.12283-2-tiwai@suse.de>
References: <20161108141856.12283-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D0426680F
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 15:18:59 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9EBE9ABF4
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 14:18:58 +0000 (UTC)
In-Reply-To: <20161108141856.12283-1-tiwai@suse.de>
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

The ALSA proc handler allows currently the write in the unlimited size
until kmalloc() fails.  But basically the write is supposed to be only
for small inputs, mostly for one line inputs, and we don't have to
handle too large sizes at all.  Since the kmalloc error results in the
kernel warning, it's better to limit the size beforehand.

This patch adds the limit of 16kB, which must be large enough for the
currently existing code.

Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/info.c b/sound/core/info.c
index 895362a696c9..291d6ed80d80 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -329,6 +329,9 @@ static ssize_t snd_info_text_entry_write(struct file *file,
 	if (!valid_pos(pos, count))
 		return -EIO;
 	next = pos + count;
+	/* don't handle too large text inputs */
+	if (next > 16 * 1024)
+		return -EIO;
 	mutex_lock(&entry->access);
 	buf = data->wbuffer;
 	if (!buf) {
-- 
2.10.2
