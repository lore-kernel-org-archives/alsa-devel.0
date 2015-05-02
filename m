From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ALSA: jack: fix a randconfig build issue
Date: Sat,  2 May 2015 15:28:07 +0800
Message-ID: <1430551687-16359-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C238E26548B
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2015 09:24:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Building errors reported such as below when 'CONFIG_INPUT=m':
    ...undefined reference to `input_xxx'...

Here change to enable SND_JACK selectively to fix the issue.

Also remove the config 'SND_HDA_INPUT_JACK' which won't be
used anymore.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/pci/hda/Kconfig     | 10 +---------
 sound/pci/hda/hda_codec.h |  2 --
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 5c296d3..117bf5c 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -4,7 +4,7 @@ config SND_HDA
 	tristate
 	select SND_PCM
 	select SND_VMASTER
-	select SND_JACK
+	select SND_JACK if INPUT=y || INPUT=SND
 	select SND_HDA_CORE
 
 config SND_HDA_INTEL
@@ -84,14 +84,6 @@ config SND_HDA_INPUT_BEEP_MODE
 	  Set 1 to always enable the digital beep interface for HD-audio by
 	  default.
 
-config SND_HDA_INPUT_JACK
-	bool "Support jack plugging notification via input layer"
-	depends on INPUT=y || INPUT=SND
-	select SND_JACK
-	help
-	  Say Y here to enable the jack plugging notification via
-	  input layer.
-
 config SND_HDA_PATCH_LOADER
 	bool "Support initialization patch loading for HD-audio"
 	select FW_LOADER
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 0f8b6b5..ed7e9cf 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -274,10 +274,8 @@ struct hda_codec {
 	unsigned long jackpoll_interval; /* In jiffies. Zero means no poll, rely on unsol events */
 	struct delayed_work jackpoll_work;
 
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	/* jack detection */
 	struct snd_array jacks;
-#endif
 
 	int depop_delay; /* depop delay in ms, -1 for default delay time */
 
-- 
1.9.1
