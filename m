From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH - alsa-plugins 2/2] a52 - set channel layout
	with recent libavcodec
Date: Fri, 27 Nov 2009 17:15:46 +0200
Message-ID: <1259334946-26319-2-git-send-email-anssi.hannula@iki.fi>
References: <1259334946-26319-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1259334946-26319-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As of SVN r18631 (2009-04-20) A52 encoder of libavcodec outputs a
warning at run-time if channel layout is not specified.

Fix that by setting the channel layout in a52_prepare() when building
against libavcodec revision that supports this.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 a52/pcm_a52.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index b95d7d4..ed491b3 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -436,6 +436,21 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
+#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 3)
+	switch (io->channels) {
+	case 2:
+		rec->avctx->channel_layout = CH_LAYOUT_STEREO;
+		break;
+	case 4:
+		rec->avctx->channel_layout = CH_LAYOUT_QUAD;
+		break;
+	case 6:
+		rec->avctx->channel_layout = CH_LAYOUT_5POINT1;
+		break;
+	default:
+		break;
+	}
+#endif
 
 	if (avcodec_open(rec->avctx, rec->codec) < 0)
 		return -EINVAL;
-- 
1.6.4.4
