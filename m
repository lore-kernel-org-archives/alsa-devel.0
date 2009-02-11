From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Cleanup setting of pin_configs in
	patch_stac927x
Date: Wed, 11 Feb 2009 20:33:15 -0200
Message-ID: <200902112033.15698.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id CAA9D1038D2
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 23:33:18 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6D3783EB6
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 17:33:33 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id hwFDOSb--RbP for <alsa-devel@alsa-project.org>;
	Wed, 11 Feb 2009 17:33:33 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 15DB93EB1
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 17:33:33 -0500 (EST)
Received: from palo.localnet (unknown [172.21.225.10])
	by fox.conectiva (Postfix) with ESMTP id 577242F215
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 19:33:16 -0300 (BRT)
Content-Disposition: inline
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

After commit "ALSA: hda - Fix restore of pin configs at resume for
STAC/IDT codecs", the introduced stac_save_pin_cfgs function checks
already for pins == NULL case, saving then default pin configs from
machine with stac92xx_save_bios_config_regs. So we can remove the
extra checks when stac927x_brd_tbl[spec->board_config] == NULL.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_sigmatel.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 12b3088..6fa064d 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5292,10 +5292,9 @@ static int patch_stac927x(struct hda_codec *codec)
 							stac927x_models,
 							stac927x_cfg_tbl);
  again:
-	if (spec->board_config < 0 || !stac927x_brd_tbl[spec->board_config]) {
-		if (spec->board_config < 0)
-			snd_printdd(KERN_INFO "hda_codec: Unknown model for"
-				    "STAC927x, using BIOS defaults\n");
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+			    "STAC927x, using BIOS defaults\n");
 		err = stac92xx_save_bios_config_regs(codec);
 	} else
 		err = stac_save_pin_cfgs(codec,
-- 
1.6.1.3
