From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 05/23] aplay: add an implementation of
	container for raw format
Date: Thu, 17 Aug 2017 20:59:46 +0900
Message-ID: <20170817120004.15326-6-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EFC9B266EB1
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:13 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This commit adds support for raw data without any headers/chunks/blocks.
---
 aplay/container.c | 30 ++++++++++++++++++++++++++++--
 aplay/container.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/aplay/container.c b/aplay/container.c
index 1cd7ada..f8fe296 100644
--- a/aplay/container.c
+++ b/aplay/container.c
@@ -23,14 +23,24 @@ static const char *const cntr_format_labels[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE] = "riff/wave",
 	[CONTAINER_FORMAT_AU] = "au",
 	[CONTAINER_FORMAT_VOC] = "voc",
+	[CONTAINER_FORMAT_RAW] = "raw",
 };
 
 static const char *const suffixes[] = {
 	[CONTAINER_FORMAT_RIFF_WAVE]	= ".wav",
 	[CONTAINER_FORMAT_AU]		= ".au",
 	[CONTAINER_FORMAT_VOC]		= ".voc",
+	[CONTAINER_FORMAT_RAW]		= "",
 };
 
+/* Raw container. */
+static const struct container_parser container_parser_raw = {
+	.format = CONTAINER_FORMAT_RAW,
+};
+
+static const struct container_builder container_builder_raw = {
+	.format = CONTAINER_FORMAT_RAW,
+};
 
 const char *const container_suffix_from_format(enum container_format format)
 {
@@ -112,7 +122,7 @@ enum container_format container_format_from_path(const char *path)
 	}
 
 	/* Unsupported. */
-	return CONTAINER_FORMAT_COUNT;
+	return CONTAINER_FORMAT_RAW;
 }
 
 int container_seek_offset(struct container_context *cntr, off64_t offset)
@@ -196,7 +206,7 @@ int container_parser_init(struct container_context *cntr,
 	 * Unless detected, use raw container.
 	 */
 	if (i == ARRAY_SIZE(parsers))
-		return -EINVAL;
+		parser = &container_parser_raw;
 
 	/* Allocate private data for the parser. */
 	if (parser->private_size > 0) {
@@ -224,6 +234,7 @@ int container_builder_init(struct container_context *cntr,
 		[CONTAINER_FORMAT_RIFF_WAVE] = &container_builder_riff_wave,
 		[CONTAINER_FORMAT_AU] = &container_builder_au,
 		[CONTAINER_FORMAT_VOC] = &container_builder_voc,
+		[CONTAINER_FORMAT_RAW] = &container_builder_raw,
 	};
 	const struct container_builder *builder;
 	int err;
@@ -306,6 +317,21 @@ int container_context_process_frames(struct container_context *cntr,
 			    *frame_count;
 	int err;
 
+	/*
+	 * A parser of cotainers already read first 4 bytes to detect format
+	 * of container, however they includes PCM frames when any format was
+	 * undetected. Surely to write out them.
+	 */
+	if (!cntr->magic_handled && cntr->type == CONTAINER_TYPE_PARSER &&
+	    cntr->format == CONTAINER_FORMAT_RAW) {
+		memcpy(buf, cntr->magic, sizeof(cntr->magic));
+		buf += sizeof(cntr->magic);
+		size -= sizeof(cntr->magic);
+		cntr->magic_handled = true;
+
+		cntr->handled_byte_count += sizeof(cntr->magic);
+	}
+
 	/* All of supported containers include interleaved PCM frames. */
 	err = cntr->process_bytes(cntr, buf, size);
 	if (err < 0) {
diff --git a/aplay/container.h b/aplay/container.h
index 994ff9b..01ad7af 100644
--- a/aplay/container.h
+++ b/aplay/container.h
@@ -33,6 +33,7 @@ enum container_format {
 	CONTAINER_FORMAT_RIFF_WAVE = 0,
 	CONTAINER_FORMAT_AU,
 	CONTAINER_FORMAT_VOC,
+	CONTAINER_FORMAT_RAW,
 	CONTAINER_FORMAT_COUNT,
 };
 
-- 
2.11.0
