From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 3/4] ALSA: compress: Don't allow paritial
	drain operations on capture streams
Date: Mon, 22 Jul 2019 10:24:35 +0100
Message-ID: <20190722092436.651-3-ckeepax@opensource.cirrus.com>
References: <20190722092436.651-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A65DFF8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 11:24:42 +0200 (CEST)
In-Reply-To: <20190722092436.651-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: vkoul@kernel.org, tiwai@suse.com
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Partial drain and next track are intended for gapless playback and
don't really have an obvious interpretation for a capture stream, so
makes sense to not allow those operations on capture streams.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Continue to allow drain on capture streams.

Thanks,
Charles

 sound/core/compress_offload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 40dae723c59db..6cf5b8440cf30 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -834,6 +834,10 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
 	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
 		return -EPERM;
 
+	/* next track doesn't have any meaning for capture streams */
+	if (stream->direction == SND_COMPRESS_CAPTURE)
+		return -EPERM;
+
 	/* you can signal next track if this is intended to be a gapless stream
 	 * and current track metadata is set
 	 */
@@ -861,6 +865,10 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 		break;
 	}
 
+	/* partial drain doesn't have any meaning for capture streams */
+	if (stream->direction == SND_COMPRESS_CAPTURE)
+		return -EPERM;
+
 	/* stream can be drained only when next track has been signalled */
 	if (stream->next_track == false)
 		return -EPERM;
-- 
2.11.0
