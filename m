From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH 2/2] ALSA: hda: Fix a mask wrong issue in
	snd_hdac_stream_start()
Date: Wed,  9 Jan 2019 16:20:51 +0800
Message-ID: <20190109082051.32643-2-yang.jie@linux.intel.com>
References: <20190109082051.32643-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE1D267002
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 09:19:14 +0100 (CET)
In-Reply-To: <20190109082051.32643-1-yang.jie@linux.intel.com>
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
Cc: Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

To enable SIE(Stream Interrupt Enable) in snd_hdac_stream_start(), we
should set both mask and value to be "1 << azx_dev->index" for register
update, the mask was 0, here fix it.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/hda/hdac_stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index eee422390d8e..ba73a33480b6 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -56,7 +56,9 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 		azx_dev->start_wallclk -= azx_dev->period_wallclk;
 
 	/* enable SIE */
-	snd_hdac_chip_updatel(bus, INTCTL, 0, 1 << azx_dev->index);
+	snd_hdac_chip_updatel(bus, INTCTL,
+			      1 << azx_dev->index,
+			      1 << azx_dev->index);
 	/* set DMA start and interrupt mask */
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				0, SD_CTL_DMA_START | SD_INT_MASK);
-- 
2.17.1
