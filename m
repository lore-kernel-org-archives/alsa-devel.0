From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ALSA: compress: Fix stop handling on
	compressed capture streams
Date: Tue, 5 Feb 2019 16:29:40 +0000
Message-ID: <20190205162940.1028-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E3D52666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:29:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, vkoul@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

It is normal user behaviour to start, stop, then start a stream
again without closing it. Currently this works for compressed
playback streams but not capture ones.

The states on a compressed capture stream go directly from OPEN to
PREPARED, unlike a playback stream which moves to SETUP and waits
for a write of data before moving to PREPARED. Currently however,
when a stop is sent the state is set to SETUP for both types of
streams. This leaves a capture stream in the situation where a new
start can't be sent as that requires the state to be PREPARED and
a new set_params can't be sent as that requires the state to be
OPEN. The only option being to close the stream, and then reopen.

Correct this issues by allowing snd_compr_drain_notify to set the
state depending on the stream direction, as we already do in
set_params.

Fixes: 49bb6402f1aa ("ALSA: compress_core: Add support for capture streams")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/compress_driver.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 0cdc3999ecfa8..c5188ff724d12 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -173,7 +173,11 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	else
+		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+
 	wake_up(&stream->runtime->sleep);
 }
 
-- 
2.11.0
