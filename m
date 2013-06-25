From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH] ALSA: hda - Add In-driver connection info
Date: Mon, 24 Jun 2013 23:41:23 -0400
Message-ID: <1372131683-2044-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E621265255
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 04:31:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Pin's connection list may change dynamically with hot-plug event
on Intel Haswell chip. Users would see connections be "0" in codec#.
when play audio on this pin, software driver choose converter from cache
connections. So add "In-driver connection" info to avoid confuse when
raw connections are different with cache connection.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_proc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 0fee8fa..9760f00 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -504,6 +504,8 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 			    int conn_len)
 {
 	int c, curr = -1;
+	const hda_nid_t *list;
+	int cache_len;
 
 	if (conn_len > 1 &&
 	    wid_type != AC_WID_AUD_MIX &&
@@ -521,6 +523,19 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 		}
 		snd_iprintf(buffer, "\n");
 	}
+
+	/* Get Cache connections info */
+	cache_len = snd_hda_get_conn_list(codec, nid, &list);
+	if (cache_len != conn_len
+			|| memcmp(list, conn, conn_len)) {
+		snd_iprintf(buffer, "  In-driver Connection: %d\n", cache_len);
+		if (cache_len > 0) {
+			snd_iprintf(buffer, "    ");
+			for (c = 0; c < cache_len; c++)
+				snd_iprintf(buffer, " 0x%02x", list[c]);
+			snd_iprintf(buffer, "\n");
+		}
+	}
 }
 
 static void print_gpio(struct snd_info_buffer *buffer,
-- 
1.8.1.2
