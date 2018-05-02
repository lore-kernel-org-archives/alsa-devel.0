From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enforce CONFIG_SND_DYNAMIC_MINORS
	for HDMI/DP codec
Date: Wed,  2 May 2018 09:18:31 +0200
Message-ID: <20180502071831.4653-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 808FC266EBE
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 09:18:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1729AADDC
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 07:18:32 +0000 (UTC)
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

The DP-MST support requires more PCM streams than usual, hence
CONFIG_SND_DYNAMIC_MINORS is almost mandatory.  Currently the driver
just warns and continues even if streams are missing, but it doesn't
seem to enough convince users to switch to the modern setup.

This patch adds the enforced selection of CONFIG_SND_DYNAMIC_MINORS
from CONFIG_SND_HDA_CODEC_HDMI for covering that.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index f7a492c382d9..4235907b7858 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -127,11 +127,15 @@ comment "Set to Y if you want auto-loading the codec driver"
 
 config SND_HDA_CODEC_HDMI
 	tristate "Build HDMI/DisplayPort HD-audio codec support"
+	select SND_DYNAMIC_MINORS
 	help
 	  Say Y or M here to include HDMI and DisplayPort HD-audio codec
 	  support in snd-hda-intel driver.  This includes all AMD/ATI,
 	  Intel and Nvidia HDMI/DisplayPort codecs.
 
+	  Note that this option mandatorily enables CONFIG_SND_DYNAMIC_MINORS
+	  to assure the multiple streams for DP-MST support.
+
 comment "Set to Y if you want auto-loading the codec driver"
 	depends on SND_HDA=y && SND_HDA_CODEC_HDMI=m
 
-- 
2.16.3
