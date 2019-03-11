From: Mariusz Ceier <mceier+kernel@gmail.com>
Subject: [PATCH 1/1] sound/hda/hdac_stream: Avoid NULL pointer dereference
Date: Mon, 11 Mar 2019 21:53:57 +0100
Message-ID: <20190311205357.7573-2-mceier+kernel@gmail.com>
References: <20190311205357.7573-1-mceier+kernel@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311205357.7573-1-mceier+kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ravindra Lokhande <rlokhande@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mohan Kumar D <mkumard@nvidia.com>, Keyon Jie <yang.jie@linux.intel.com>, Mariusz Ceier <mceier+kernel@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For ca0132 codec, azx_dev->stream is NULL during firmware loading.
Calling snd_hdac_get_stream_stripe_ctl unconditionally causes NULL
pointer dereference in that function.

Signed-off-by: Mariusz Ceier <mceier+kernel@gmail.com>
---
 sound/hda/hdac_stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f5dd288d1a7a..76e9b41fcea2 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -95,7 +95,10 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 			      1 << azx_dev->index,
 			      1 << azx_dev->index);
 	/* set stripe control */
-	stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+	if (azx_dev->substream)
+		stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+	else
+		stripe_ctl = 0;
 	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK,
 				stripe_ctl);
 	/* set DMA start and interrupt mask */
-- 
2.21.0
