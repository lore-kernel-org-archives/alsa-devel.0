From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: HDA: remove the unused function
	declaration
Date: Thu, 11 Jun 2015 22:11:49 +0530
Message-ID: <1434040909-14813-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DE07326657D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:40:27 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Commit a1b3fda6ae ALSA: hdac_ext: add hdac extended controller,
erroneously added snd_hdac_ext_bus_map_codec_to_link() function
declaration, so remove it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 0044caa19155..202350a8eddb 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -47,7 +47,6 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *chip,
 				 bool enable, int index);
 
 int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *bus);
-int snd_hdac_ext_bus_map_codec_to_link(struct hdac_ext_bus *bus, int addr);
 struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *bus,
 						const char *codec_name);
 
-- 
1.9.1
