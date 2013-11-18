From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Select FW_LOADER from
	CONFIG_SND_HDA_CODEC_CA0132_DSP
Date: Mon, 18 Nov 2013 17:14:39 +0100
Message-ID: <1384791279-4080-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43486260845
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 17:14:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B83AAA79B7
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 17:14:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use select FW_LOADER instead of depends on.  It's more intuitive and
more consistent with other entries.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 8de66ccd7279..4cdd9ded4563 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -209,8 +209,9 @@ config SND_HDA_CODEC_CA0132
 
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
-	depends on SND_HDA_CODEC_CA0132 && FW_LOADER
+	depends on SND_HDA_CODEC_CA0132
 	select SND_HDA_DSP_LOADER
+	select FW_LOADER
 	help
 	  Say Y here to enable the DSP for Creative CA0132 for extended
 	  features like equalizer or echo cancellation.
-- 
1.8.4.3
