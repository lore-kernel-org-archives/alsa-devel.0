From: jeeja.kp@intel.com
Subject: [PATCH] ASoC: Intel: Skylake: Use DPIB to update
	position for Playback stream
Date: Thu,  6 Oct 2016 08:51:21 +0530
Message-ID: <1475724081-15129-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0029E26655F
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 05:12:30 +0200 (CEST)
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
Cc: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

DPIB is read currently from a buffer position in memory (indicated by
the registers DPIB[U|L]BASE).Driver reads the position buffer on BDL
completion interrupts to report the DMA position. But the BDL completion
interrupt only indicates the last DMA transfer of the buffer is
completed at the Intel HD Audio subsystem boundary. The periodic DMA
Position-in-Buffer writes may be scheduled at the same time or later
than the MSI and does not guarantee to reflect the position of the last
buffer that was transferred.

Whereas DPIB register in HDA space(vendor specific register indicated by
SDxDPIB) reflects the actual data that is transferred. Hence update the
position based on DPIB for playback.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 9edf5ba..b2a067b 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1053,10 +1053,24 @@ static snd_pcm_uframes_t skl_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct hdac_ext_stream *hstream = get_hdac_ext_stream(substream);
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 	unsigned int pos;
 
-	/* use the position buffer as default */
-	pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
+	/*
+	 * Use DPIB for Playback stream as the periodic DMA Position-in-
+	 * Buffer Writes may be scheduled at the same time or later than
+	 * the MSI and does not guarantee to reflect the Position of the
+	 * last buffer that was transferred. Whereas DPIB register in
+	 * HAD space reflects the actual data that is transferred.
+	 * Use the position buffer for capture, as DPIB write gets
+	 * completed earlier than the actual data written to the DDR.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		pos = readl(ebus->bus.remap_addr + AZX_REG_VS_SDXDPIB_XBASE +
+				(AZX_REG_VS_SDXDPIB_XINTERVAL *
+				hdac_stream(hstream)->index));
+	else
+		pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
 
 	if (pos >= hdac_stream(hstream)->bufsize)
 		pos = 0;
-- 
2.5.0
