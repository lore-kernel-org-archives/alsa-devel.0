From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/5] hda-emu: Improve error message for modem
	codecs
Date: Thu,  4 Sep 2014 14:21:05 +0200
Message-ID: <1409833267-9778-4-git-send-email-david.henningsson@canonical.com>
References: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CED926589F
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 14:21:07 +0200 (CEST)
In-Reply-To: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In some cases (when codec index parameter was specified),
selecting a modem codec resulted in "ERROR -77", which was
confusing.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-parse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hda-parse.c b/hda-parse.c
index 57e9ee3..b5abd5e 100644
--- a/hda-parse.c
+++ b/hda-parse.c
@@ -675,13 +675,17 @@ int parse_codec_proc(FILE *fp, struct xhda_codec *codecp, int codec_index)
 			parse_mode = PARSE_ROOT;
 		}
 		err = parse_codec_recursive(buffer);
-		if (err < 0) {
-			if (err == -EBADFD && codec_index < 0) {
+		if (err == -EBADFD) {
+			if (codec_index < 0) {
 				hda_log(HDA_LOG_INFO, "Codec %d is a modem codec, skipping\n", curidx);
 				parse_mode = PARSE_START;
 				clear_codec(codec);
 				continue;
 			}
+			hda_log(HDA_LOG_ERR, "Codec %d is a modem codec, aborting\n", curidx);
+			return err;
+		}
+		else if (err < 0) {
 			hda_log(HDA_LOG_ERR, "ERROR %d\n", err);
 			return err;
 		}
-- 
1.9.1
