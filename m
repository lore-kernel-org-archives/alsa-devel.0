From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use DPIB to update
	position for Playback stream" to the asoc tree
Date: Fri, 28 Oct 2016 18:02:49 +0100
Message-ID: <E1c0AYL-0003WW-Cc@finisterre>
References: <1475724081-15129-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D058266731
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 19:03:18 +0200 (CEST)
In-Reply-To: <1475724081-15129-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use DPIB to update position for Playback stream

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ca590c1c45d1d06f842a82f6a591b94af95952b0 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Thu, 6 Oct 2016 08:51:21 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use DPIB to update position for
 Playback stream

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 58c728662600..c966b40da180 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1031,10 +1031,24 @@ static snd_pcm_uframes_t skl_platform_pcm_pointer
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
2.10.1
