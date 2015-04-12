From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 04/11] ALSA: hda: corrected
	snd_hdac_stream_init() declaration
Date: Sun, 12 Apr 2015 18:06:11 +0530
Message-ID: <1428842178-7105-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4182D260600
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 15:05:55 +0200 (CEST)
In-Reply-To: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Corrected snd_hdac_stream_init() declaration in header file.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 247c4a7..bffb2a9 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -340,7 +340,7 @@ struct hdac_stream {
 	struct mutex dsp_mutex;
 };
 
-void snd_hdac_bus_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
+void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
 			      int idx, int direction, int tag);
 struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 					   struct snd_pcm_substream *substream);
-- 
1.9.0
