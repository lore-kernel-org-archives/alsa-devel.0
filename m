From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Ensure codec patch files are checked for the
 correct codec ID
Date: Mon, 26 Jul 2010 10:22:59 +0200
Message-ID: <4C4D45E3.6000606@canonical.com>
References: <4C06729B.6050201@epost.diwic.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020601030309080805090208"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A1C26246D3
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:23:00 +0200 (CEST)
In-Reply-To: <4C06729B.6050201@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020601030309080805090208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This one never got merged (and I forgot to cc Takashi...), so I'm just
reposting it.

Link to original post:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-June/028302.html

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020601030309080805090208
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


--------------020601030309080805090208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020601030309080805090208--
