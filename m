From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: hda - Remove superfluous kconfig
	depends
Date: Tue,  8 Jan 2013 12:50:44 +0100
Message-ID: <1357645849-8181-4-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FA25265F82
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 772CCA50E4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
In-Reply-To: <1357645849-8181-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index d3d7287..b901494 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -148,7 +148,6 @@ config SND_HDA_CODEC_HDMI
 
 config SND_HDA_CODEC_CIRRUS
 	bool "Build Cirrus Logic codec support"
-	depends on SND_HDA_INTEL
 	default y
 	select SND_HDA_GENERIC
 	help
@@ -174,7 +173,6 @@ config SND_HDA_CODEC_CONEXANT
 
 config SND_HDA_CODEC_CA0110
 	bool "Build Creative CA0110-IBG codec support"
-	depends on SND_HDA_INTEL
 	default y
 	help
 	  Say Y here to include Creative CA0110-IBG codec support in
@@ -187,7 +185,6 @@ config SND_HDA_CODEC_CA0110
 
 config SND_HDA_CODEC_CA0132
 	bool "Build Creative CA0132 codec support"
-	depends on SND_HDA_INTEL
 	default y
 	help
 	  Say Y here to include Creative CA0132 codec support in
-- 
1.8.0.1
