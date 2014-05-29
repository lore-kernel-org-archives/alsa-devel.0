From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/3] Revert "ALSA: hda - drop def association
	and sequence from pinconf comparing"
Date: Thu, 29 May 2014 15:59:17 +0800
Message-ID: <1401350359-5045-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B4C29260799
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 09:59:30 +0200 (CEST)
Received: by mail-pb0-f51.google.com with SMTP id ma3so12549660pbc.24
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 00:59:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This reverts commit c687200b9d4ef60042a50f7d942cfef120cc7bf1.

Dropping the def association and sequence from pinconf comparing is a
bit risky, It will introduce a greater risk of catching unwanted
machines.

And in addition, so far no BIOS experts give us an explicit answer
whether it makes senses to compare these two fields or not.

For safety reason, we revert this commit.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
This is the first attempt to move existing machines from old quirk table
to hda_pin_quirk table. During the working, I met serveral cases that
the same codec has different default pin conf value just because of
default association difference, Please see the following two patches
(0x10ec0255 and 0x10ec0668).


 sound/pci/hda/hda_auto_parser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 3cf9137..b684c6e 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -844,8 +844,7 @@ static bool pin_config_match(struct hda_codec *codec,
 {
 	for (; pins->nid; pins++) {
 		u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
-		u32 mask = 0xffffff00;
-		if ((pins->val & mask) != (def_conf & mask))
+		if (pins->val != def_conf)
 			return false;
 	}
 	return true;
-- 
1.8.1.2
