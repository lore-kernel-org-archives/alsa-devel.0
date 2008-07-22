From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] sound/pci/azt3328.h: no variables for enums
Date: Tue, 22 Jul 2008 20:21:28 +0300
Message-ID: <20080722172128.GY14846@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F3D610389A
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 19:21:39 +0200 (CEST)
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
To: Andreas Mohr <andi@lisas.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AZF_FREQUENCIES and AZF_GAME_CONFIGS were variables, and this doesn't 
seem to have been intended.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
d73b516dc7770a7141b6015b24c806fc697f066d 
diff --git a/sound/pci/azt3328.h b/sound/pci/azt3328.h
index 7e3e894..974e051 100644
--- a/sound/pci/azt3328.h
+++ b/sound/pci/azt3328.h
@@ -94,7 +94,7 @@ enum azf_freq_t {
   AZF_FREQ(48000),
   AZF_FREQ(66200),
 #undef AZF_FREQ
-} AZF_FREQUENCIES;
+};
 
 /** recording area (see also: playback bit flag definitions) **/
 #define IDX_IO_REC_FLAGS	0x20 /* ??, PU:0x0000 */
@@ -210,7 +210,7 @@ enum azf_freq_t {
 
 enum {
 	AZF_GAME_LEGACY_IO_PORT = 0x200
-} AZF_GAME_CONFIGS;
+};
 
 #define IDX_GAME_LEGACY_COMPATIBLE	0x00
 	/* in some operation mode, writing anything to this port
