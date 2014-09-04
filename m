From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/5] hda-emu: Deal with two cards with one
	codec each
Date: Thu,  4 Sep 2014 14:21:03 +0200
Message-ID: <1409833267-9778-2-git-send-email-david.henningsson@canonical.com>
References: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CFF82658A0
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

When using the -i switch to specify an index, we need to deal with
two common cases:
 1) All codecs belong to one card
 2) There are as many cards as there are codecs

This patch makes sure we pick the correct pci ID and SSID for
the second case, too.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-parse.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hda-parse.c b/hda-parse.c
index 8d9a3c7..d9fc311 100644
--- a/hda-parse.c
+++ b/hda-parse.c
@@ -481,21 +481,21 @@ static int parse_codec_recursive(const char *buffer)
 }
 	
 /* check the extra information from alsa-info output */
-static void check_alsa_info(char *line)
+static int check_alsa_info(char *line, int override)
 {
 	int dummy, classid, vendor, id, rev;
 
 	if (sscanf(line, "%02x:%02x.%1d %04x: %04x:%04x (rev %02x)",
 		   &dummy, &dummy, &dummy, &classid, &vendor, &id, &rev) == 7) {
-		if (classid == 0x0403 && !codec->pci_vendor) {
+		if (classid == 0x0403 && (override || !codec->pci_vendor)) {
 			codec->pci_vendor = vendor;
 			codec->pci_device = id;
 			codec->pci_revision = rev;
 		}
-		return;
+		return 0;
 	}
 	if (sscanf(line, "        Subsystem: %04x:%04x", &vendor, &id) == 2) {
-		if (!codec->pci_subvendor) {
+		if (override || !codec->pci_subvendor) {
 			codec->pci_subvendor = vendor;
 			codec->pci_subdevice = id;
 			hda_log(HDA_LOG_INFO, "Getting PCI ID %04x:%04x (%04x:%04x) rev %02x\n",
@@ -503,8 +503,9 @@ static void check_alsa_info(char *line)
 				codec->pci_subvendor, codec->pci_subdevice,
 				codec->pci_revision);
 		}
-		return;
+		return 1;
 	}
+	return 0;
 }
 
 static int add_sysfs_list(struct xhda_codec *codec, int *vals)
@@ -612,7 +613,7 @@ static void clear_codec(struct xhda_codec *codec)
 int parse_codec_proc(FILE *fp, struct xhda_codec *codecp, int codec_index)
 {
 	char buffer[256], *p;
-	int curidx = -1;
+	int curidx = -1, pciidx = 0;
 	int err = 0;
 
 	codec = codecp;
@@ -625,7 +626,8 @@ int parse_codec_proc(FILE *fp, struct xhda_codec *codecp, int codec_index)
 	again:
 		if (parse_mode == PARSE_START) {
 			if (!strmatch(buffer, "Codec: ")) {
-				check_alsa_info(buffer);
+				if (check_alsa_info(buffer, pciidx == codec_index))
+					pciidx++;
 				continue;
 			}
 			curidx++;
-- 
1.9.1
