From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: [PATCH] Ensure codec patch files are checked for the
 correct codec ID
Date: Wed, 02 Jun 2010 17:02:51 +0200
Message-ID: <4C06729B.6050201@epost.diwic.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000400040903050100030008"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp03.sth.basefarm.net (ch-smtp03.sth.basefarm.net
	[80.76.149.214])
	by alsa0.perex.cz (Postfix) with ESMTP id B10BC103974
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 17:03:43 +0200 (CEST)
Received: from c83-254-137-216.bredband.comhem.se ([83.254.137.216]:55272
	helo=[192.168.8.103])
	by ch-smtp03.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1OJpT2-0005cj-Bc
	for alsa-devel@alsa-project.org; Wed, 02 Jun 2010 17:02:54 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000400040903050100030008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This one just popped out when I read the source code - or is there a
reason for parsing vendorid and subid without caring about the result?

// David

--------------000400040903050100030008
Content-Type: text/x-patch;
 name="0001-Ensure-codec-patch-files-are-checked-for-the-correct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Ensure-codec-patch-files-are-checked-for-the-correct.pa";
 filename*1="tch"

>From ae4e9f41cf404d879b14be56591c4d5c6b403b71 Mon Sep 17 00:00:00 2001
From: David Henningsson <diwic@ubuntu.com>
Date: Wed, 2 Jun 2010 16:56:41 +0200
Subject: [PATCH] Ensure codec patch files are checked for the correct codec ID
 Signed-off-by: David Henningsson <diwic@ubuntu.com>

---
 sound/pci/hda/hda_hwdep.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index a1fc837..0e2cb27 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -649,7 +649,9 @@ static void parse_codec_mode(char *buf, struct hda_bus *bus,
 	*codecp = NULL;
 	if (sscanf(buf, "%i %i %i", &vendorid, &subid, &caddr) == 3) {
 		list_for_each_entry(codec, &bus->codec_list, list) {
-			if (codec->addr == caddr) {
+			if (codec->vendor_id == vendorid && 
+					codec->subsystem_id == subid && 
+					codec->addr == caddr) {
 				*codecp = codec;
 				break;
 			}
-- 
1.7.0.4


--------------000400040903050100030008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000400040903050100030008--
