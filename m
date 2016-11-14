From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: compress: Fix kernel-doc warnings
Date: Mon, 14 Nov 2016 22:30:04 +0100
Message-ID: <20161114213005.22443-3-tiwai@suse.de>
References: <20161114213005.22443-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CAF59266623
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 22:30:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8B416AC34
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 21:30:10 +0000 (UTC)
In-Reply-To: <20161114213005.22443-1-tiwai@suse.de>
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

Some fields in struct snd_compr have no corresponding comments, and
the kernel-doc complains like:

  ./include/sound/compress_driver.h:162: warning: No description found for parameter 'id[64]'
  ./include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_root'
  ./include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_info_entry'

Actually all these are internal elements, just put "private:" comment
so that they will be ignored.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/compress_driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index cee8c00f3d3e..9924bc9cbc7c 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -155,6 +155,7 @@ struct snd_compr {
 	struct mutex lock;
 	int device;
 #ifdef CONFIG_SND_VERBOSE_PROCFS
+	/* private: */
 	char id[64];
 	struct snd_info_entry *proc_root;
 	struct snd_info_entry *proc_info_entry;
-- 
2.10.2
