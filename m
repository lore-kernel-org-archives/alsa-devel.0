From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: revert change to 92hd83xxx power mapping
Date: Thu, 22 Jan 2009 20:38:42 -0500
Message-ID: <49791FA2.6020707@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 213FC1037E3
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 02:38:57 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Port 0xe power mapping was incorrect set to 0x80 changed to the correct value 0x40.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index dbe8b12..dd750d6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -334,7 +334,7 @@ static hda_nid_t stac92hd83xxx_slave_dig_outs[2] = {
 };
 
 static unsigned int stac92hd83xxx_pwr_mapping[4] = {
-	0x03, 0x0c, 0x20, 0x80,
+	0x03, 0x0c, 0x20, 0x40,
 };
 
 static hda_nid_t stac92hd83xxx_amp_nids[1] = {
