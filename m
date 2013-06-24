From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/2 V2] ALSA: hda - Add cache connection info
Date: Mon, 24 Jun 2013 09:10:19 -0400
Message-ID: <1372079419-31903-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1372079419-31903-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 066C42625CE
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 13:59:56 +0200 (CEST)
In-Reply-To: <1372079419-31903-1-git-send-email-xingchao.wang@linux.intel.com>
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
when play audio on this pin, software choose connections from cache.
So add Cache connection info to avoid confuse.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_proc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 0fee8fa..403589c 100644
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
@@ -511,7 +513,7 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 	    wid_type != AC_WID_POWER)
 		curr = snd_hda_codec_read(codec, nid, 0,
 					  AC_VERB_GET_CONNECT_SEL, 0);
-	snd_iprintf(buffer, "  Connection: %d\n", conn_len);
+	snd_iprintf(buffer, "  Raw Connection: %d\n", conn_len);
 	if (conn_len > 0) {
 		snd_iprintf(buffer, "    ");
 		for (c = 0; c < conn_len; c++) {
@@ -521,6 +523,19 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 		}
 		snd_iprintf(buffer, "\n");
 	}
+
+	/* Get Cache connections info */
+	cache_len = snd_hda_get_conn_list(codec, nid, &list);
+	if (cache_len != conn_len
+			|| memcmp(list, conn, conn_len)) {
+		snd_iprintf(buffer, "  Cache Connection: %d\n", conn_len);
+		if (cache_len > 0) {
+			snd_iprintf(buffer, "    ");
+			for (c = 0; c < conn_len; c++)
+				snd_iprintf(buffer, " 0x%02x", list[c]);
+			snd_iprintf(buffer, "\n");
+		}
+	}
 }
 
 static void print_gpio(struct snd_info_buffer *buffer,
-- 
1.8.1.2
