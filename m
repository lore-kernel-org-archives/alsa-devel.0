From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/2] ALSA: hda - Add cache connection info
Date: Fri, 21 Jun 2013 12:41:48 +0800
Message-ID: <1371789708-10524-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1371789708-10524-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ECBF26546E
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 07:10:01 +0200 (CEST)
In-Reply-To: <1371789708-10524-1-git-send-email-xingchao.wang@linux.intel.com>
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Pin's connection list may change dynamically with hot-plug event
on Intel Haswell chip. Users would see connections be "0" in codec#.
when play audio on this pin, software choose connections from cache.
So add Cache connection info to avoid confuse.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 13 +++++++++++++
 sound/pci/hda/hda_codec.h |  2 ++
 sound/pci/hda/hda_proc.c  | 13 ++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 55108b5..7517fd6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -354,6 +354,19 @@ lookup_conn_list(struct hda_codec *codec, hda_nid_t nid)
 	return NULL;
 }
 
+int lookup_cache_conn(struct hda_codec *codec,
+	       hda_nid_t pin_nid, hda_nid_t *conn_list)
+{
+	struct hda_conn_list *p;
+
+	p = lookup_conn_list(codec, pin_nid);
+	if (p) {
+		memcpy(conn_list, p->conns, p->len * sizeof(hda_nid_t));
+		return p->len;
+	}
+	return 0;
+}
+
 static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 			 const hda_nid_t *list)
 {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index c93f902..145d184 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -963,6 +963,8 @@ snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
 int snd_hda_get_num_raw_conns(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
 			    hda_nid_t *conn_list, int max_conns);
+int lookup_cache_conn(struct hda_codec *codec,
+	       hda_nid_t pin_nid, hda_nid_t *conn_list);
 int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 			  const hda_nid_t **listp);
 int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 0fee8fa..e52ad3c 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -504,6 +504,7 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 			    int conn_len)
 {
 	int c, curr = -1;
+	hda_nid_t cache_conn[4];
 
 	if (conn_len > 1 &&
 	    wid_type != AC_WID_AUD_MIX &&
@@ -511,7 +512,7 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 	    wid_type != AC_WID_POWER)
 		curr = snd_hda_codec_read(codec, nid, 0,
 					  AC_VERB_GET_CONNECT_SEL, 0);
-	snd_iprintf(buffer, "  Connection: %d\n", conn_len);
+	snd_iprintf(buffer, "  Raw Connection: %d\n", conn_len);
 	if (conn_len > 0) {
 		snd_iprintf(buffer, "    ");
 		for (c = 0; c < conn_len; c++) {
@@ -521,6 +522,16 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 		}
 		snd_iprintf(buffer, "\n");
 	}
+
+	/* Get Cache connections info */
+	conn_len = lookup_cache_conn(codec, nid, cache_conn);
+	if (conn_len > 0) {
+		snd_iprintf(buffer, "  Cache Connection: %d\n", conn_len);
+		snd_iprintf(buffer, "    ");
+		for (c = 0; c < conn_len; c++)
+			snd_iprintf(buffer, " 0x%02x", cache_conn[c]);
+		snd_iprintf(buffer, "\n");
+	}
 }
 
 static void print_gpio(struct snd_info_buffer *buffer,
-- 
1.8.1.2
