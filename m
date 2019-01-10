From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/5] ALSA: hda: program stripe bits for
	controller
Date: Thu, 10 Jan 2019 22:33:24 +0530
Message-ID: <1547139805-1904-4-git-send-email-spujar@nvidia.com>
References: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 516252674E1
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 18:03:56 +0100 (CET)
In-Reply-To: <1547139805-1904-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Platforms having multiple hdmi/dp sinks require higher bandwidth
to support simultaneous playbacks of higher resolution. If hda
controller supports multiple SDO lines, STRIPE can be used to
indicate how many of the SDO lines the stream should be striped
across.

During stream start stripe control bits are programmed to use given
number of sdo lines and the same is cleared during stream stop.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
---
 sound/hda/hdac_stream.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index b403b05..7dbaecc 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -82,6 +82,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_init);
 void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 {
 	struct hdac_bus *bus = azx_dev->bus;
+	int stripe_ctl;
 
 	trace_snd_hdac_stream_start(bus, azx_dev);
 
@@ -91,6 +92,9 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 
 	/* enable SIE */
 	snd_hdac_chip_updatel(bus, INTCTL, 0, 1 << azx_dev->index);
+	/* set stripe control */
+	stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, 0, stripe_ctl & 0x3);
 	/* set DMA start and interrupt mask */
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				0, SD_CTL_DMA_START | SD_INT_MASK);
@@ -107,6 +111,7 @@ void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				SD_CTL_DMA_START | SD_INT_MASK, 0);
 	snd_hdac_stream_writeb(azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
+	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, 0x3, 0);
 	azx_dev->running = false;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_clear);
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
