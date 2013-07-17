From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] firewire-speakers: add functions to handle payload
Date: Wed, 17 Jul 2013 20:50:48 +0900
Message-ID: <1374061848-5851-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: sakamocchi <o-takashi@sakamocchi.jp>

With my previous three patches, each driver can handle payload of AMDTP packet.
This commit adapts existed firewire-speakers driver to it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 speakers.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/speakers.c b/speakers.c
index 2c63865..a0b0b14 100644
--- a/speakers.c
+++ b/speakers.c
@@ -50,6 +50,7 @@ struct fwspk {
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct snd_pcm_substream *pcm;
+	unsigned int pcm_channels;
 	struct mutex mutex;
 	struct cmp_connection connection;
 	struct amdtp_out_stream stream;
@@ -147,7 +148,7 @@ static int fwspk_open(struct snd_pcm_substream *substream)
 			SNDRV_PCM_INFO_BATCH |
 			SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_BLOCK_TRANSFER,
-		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
+		.formats = SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S32,
 		.channels_min = 2,
 		.channels_max = 2,
 		.buffer_bytes_max = 4 * 1024 * 1024,
@@ -247,11 +248,10 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto error;
 
+	fwspk->pcm_channels = params_channels(hw_params);
 	amdtp_out_stream_set_rate(&fwspk->stream, params_rate(hw_params));
-	amdtp_out_stream_set_pcm(&fwspk->stream, params_channels(hw_params));
-
-	amdtp_out_stream_set_pcm_format(&fwspk->stream,
-					params_format(hw_params));
+	amdtp_out_stream_set_data_block_quadlets(&fwspk->stream,
+						 params_channels(hw_params));
 
 	err = fwspk_set_rate(fwspk, fwspk->stream.sfc);
 	if (err < 0)
@@ -276,6 +276,87 @@ static int fwspk_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
+static void write_silence(struct amdtp_out_stream *s,
+			  __be32 *buffer, unsigned int data_blocks)
+{
+	struct fwspk *fwspk = container_of(s, struct fwspk, stream);
+	unsigned int i, c;
+
+	for (i = 0; i < data_blocks; i++) {
+		for (c = 0; c < fwspk->pcm_channels; c++)
+			buffer[c] = cpu_to_be32(0x40000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static unsigned int write_s32(struct amdtp_out_stream *s,
+			      struct snd_pcm_runtime *runtime,
+			      __be32 *buffer, unsigned int data_blocks)
+{
+	struct fwspk *fwspk = container_of(s, struct fwspk, stream);
+	unsigned int remaining_frames, frames, i, c;
+	const u32 *src;
+
+	src = (void *)runtime->dma_area +
+			bytes_to_frames(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	frames = 0;
+	for (i = 0; i < data_blocks; i++) {
+		for (c = 0; c < fwspk->pcm_channels; c++) {
+			buffer[c] = cpu_to_be32((*src >> 8) | 0x40000000);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		frames++;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+	return frames;
+}
+
+static unsigned int write_s16(struct amdtp_out_stream *s,
+			      struct snd_pcm_runtime *runtime,
+			      __be32 *buffer, unsigned int data_blocks)
+{
+	struct fwspk *fwspk = container_of(s, struct fwspk, stream);
+	unsigned int remaining_frames, frames, i, c;
+	const u16 *src;
+
+	src = (void *)runtime->dma_area +
+			bytes_to_frames(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	frames = 0;
+	for (i = 0; i < data_blocks; i++) {
+		for (c = 0; c < fwspk->pcm_channels; c++) {
+			buffer[c] = cpu_to_be32((*src << 8) | 0x400000000);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		frames++;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+	return frames;
+}
+
+static unsigned int write_payload(struct amdtp_out_stream *s,
+				  struct snd_pcm_substream *pcm,
+				  __be32 *buffer, unsigned int data_blocks)
+{
+	buffer += 2;
+
+	if (!pcm) {
+		write_silence(s, buffer, data_blocks);
+		return 0;
+	} else if ((pcm->runtime->format == SNDRV_PCM_FORMAT_S32_LE) ||
+                   (pcm->runtime->format == SNDRV_PCM_FORMAT_S32_BE))
+		return write_s32(s, pcm->runtime, buffer, data_blocks);
+	else
+		return write_s16(s, pcm->runtime, buffer, data_blocks);
+}
+
 static int fwspk_prepare(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
@@ -294,7 +375,8 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 
 		err = amdtp_out_stream_start(&fwspk->stream,
 					fwspk->connection.resources.channel,
-					fwspk->connection.speed);
+					fwspk->connection.speed,
+					write_payload);
 		if (err < 0)
 			goto err_connection;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
