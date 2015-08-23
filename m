From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/3] ALSA: hdac: fix the spbmaxfifo API
Date: Sun, 23 Aug 2015 11:52:50 +0530
Message-ID: <1440310971-14849-2-git-send-email-vinod.koul@intel.com>
References: <1440310971-14849-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 83EC326047C
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 08:20:43 +0200 (CEST)
In-Reply-To: <1440310971-14849-1-git-send-email-vinod.koul@intel.com>
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

spbmaxfifo API is actually a query function not a set function so
name it snd_hdac_ext_stream_get_spbmaxfifo()

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h     | 2 +-
 sound/hda/ext/hdac_ext_stream.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 9385c99a6504..94210dcdb6ea 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -107,7 +107,7 @@ void snd_hdac_ext_stop_streams(struct hdac_ext_bus *sbus);
 
 int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 				 struct hdac_ext_stream *stream, u32 value);
-int snd_hdac_ext_stream_set_spbmaxfifo(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
 				 struct hdac_ext_stream *stream);
 
 void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *hstream);
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index c978a9bb1db8..33ba77dd32f2 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -461,13 +461,13 @@ int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_spib);
 
 /**
- * snd_hdac_ext_stream_set_spbmaxfifo - sets the spib value of a stream
+ * snd_hdac_ext_stream_get_spbmaxfifo - gets the spib value of a stream
  * @ebus: HD-audio ext core bus
  * @stream: hdac_ext_stream
  *
  * Return maxfifo for the stream
  */
-int snd_hdac_ext_stream_set_spbmaxfifo(struct hdac_ext_bus *ebus,
+int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
 				 struct hdac_ext_stream *stream)
 {
 	struct hdac_bus *bus = &ebus->bus;
@@ -479,7 +479,7 @@ int snd_hdac_ext_stream_set_spbmaxfifo(struct hdac_ext_bus *ebus,
 
 	return readl(stream->fifo_addr);
 }
-EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_spbmaxfifo);
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_get_spbmaxfifo);
 
 
 /**
-- 
1.9.1
