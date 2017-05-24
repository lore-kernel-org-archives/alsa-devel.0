From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 01/11] ALSA: pcm: introduce an alias of
	prototype to copy PCM frames
Date: Wed, 24 May 2017 09:52:45 +0900
Message-ID: <20170524005255.31223-2-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5F4E4267111
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:01 +0200 (CEST)
In-Reply-To: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Usage of the same function prototype between core and driver implementation
dedicates code lucidity. Especially, in a view of device driver developers,
if core implementation includes functions with the prototype, it's good
examples.

In current design of ALSA PCM core, when devices doesn't use DMA between
kernel space and device memory or platforms don't have good cache coherent
protocol, then drivers need to have own implementation for data
transmittion, without existent implementation inner ALSA PCM core.

However, for this purpose, ALSA PCM core includes inefficient
implementation. Additionally, in a point to which I addressed, it includes
complicated codes.

This commit introduces 'snd_pcm_copy_frames_t' to produce unified
interface for the devices and core implementations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c609b891c4c2..6cb8df081787 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -63,6 +63,10 @@ struct snd_pcm_substream;
 struct snd_pcm_audio_tstamp_config; /* definitions further down */
 struct snd_pcm_audio_tstamp_report;
 
+typedef int (*snd_pcm_copy_frames_t)(struct snd_pcm_substream *substream,
+				     unsigned int hwoff, unsigned int long data,
+				     unsigned int off, snd_pcm_uframes_t count);
+
 struct snd_pcm_ops {
 	int (*open)(struct snd_pcm_substream *substream);
 	int (*close)(struct snd_pcm_substream *substream);
-- 
2.11.0
