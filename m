From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: info: Return error for invalid
	read/write
Date: Tue,  8 Nov 2016 15:18:56 +0100
Message-ID: <20161108141856.12283-3-tiwai@suse.de>
References: <20161108141856.12283-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 091FB266F68
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 15:18:59 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AE67FACCE
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

Currently the ALSA proc handler allows read or write even if the proc
file were write-only or read-only.  It's mostly harmless, does thing
but allocating memory and ignores the input/output.  But it doesn't
tell user about the invalid use, and it's confusing and inconsistent
in comparison with other proc files.

This patch adds some sanity checks and let the proc handler returning
an -EIO error when the invalid read/write is performed.

Cc: <stable@vger.kernel.org> # v4.2+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 291d6ed80d80..8ab72e0f5932 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -325,6 +325,8 @@ static ssize_t snd_info_text_entry_write(struct file *file,
 	size_t next;
 	int err = 0;
 
+	if (!entry->c.text.write)
+		return -EIO;
 	pos = *offset;
 	if (!valid_pos(pos, count))
 		return -EIO;
@@ -369,7 +371,9 @@ static int snd_info_seq_show(struct seq_file *seq, void *p)
 	struct snd_info_private_data *data = seq->private;
 	struct snd_info_entry *entry = data->entry;
 
-	if (entry->c.text.read) {
+	if (!entry->c.text.read) {
+		return -EIO;
+	} else {
 		data->rbuffer->buffer = (char *)seq; /* XXX hack! */
 		entry->c.text.read(entry, data->rbuffer);
 	}
-- 
2.10.2
