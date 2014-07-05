From: Joe Perches <joe@perches.com>
Subject: [PATCH] ALSA: hda - Fix and neaten
	print_nid_path/debug_badness
Date: Sat, 05 Jul 2014 13:02:02 -0700
Message-ID: <1404590522.6384.62.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0159.hostedemail.com
 [216.40.44.159])
 by alsa0.perex.cz (Postfix) with ESMTP id ECAFF26553B
 for <alsa-devel@alsa-project.org>; Sat,  5 Jul 2014 22:02:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

print_nid_path has a possible buffer overflow if
struct nid_path.path values are > 256.

Avoid this and neaten the output to remove the leading ':'

Neaten debug_badness to always verify arguments.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/hda/hda_generic.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 589e47c..b293583 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -350,16 +350,16 @@ static void print_nid_path(struct hda_codec *codec,
 			   const char *pfx, struct nid_path *path)
 {
 	char buf[40];
+	char *pos = buf;
 	int i;
 
+	*pos = 0;
+	for (i = 0; i < path->depth; i++)
+		pos += scnprintf(pos, sizeof(buf) - (pos - buf), "%s%02x",
+				 pos != buf ? ":" : "",
+				 path->path[i]);
 
-	buf[0] = 0;
-	for (i = 0; i < path->depth; i++) {
-		char tmp[4];
-		sprintf(tmp, ":%02x", path->path[i]);
-		strlcat(buf, tmp, sizeof(buf));
-	}
-	codec_dbg(codec, "%s path: depth=%d %s\n", pfx, path->depth, buf);
+	codec_dbg(codec, "%s path: depth=%d '%s'\n", pfx, path->depth, buf);
 }
 
 /* called recursively */
@@ -1700,9 +1700,11 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 #define DEBUG_BADNESS
 
 #ifdef DEBUG_BADNESS
-#define debug_badness(fmt, args...)	codec_dbg(codec, fmt, ##args)
+#define debug_badness(fmt, ...)						\
+	codec_dbg(codec, fmt, ##__VA_ARGS__)
 #else
-#define debug_badness(...)
+#define debug_badness(fmt, ...)						\
+	do { if (0) codec_dbg(codec, fmt, ##__VA_ARGS__); } while (0)
 #endif
 
 #ifdef DEBUG_BADNESS
