From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH - alsa-plugins 1/2] a52 - fix 5.1 channel order
	with recent libavcodec
Date: Fri, 27 Nov 2009 17:15:45 +0200
Message-ID: <1259334946-26319-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

As of SVN r18540 libavcodec expects 5.1 channel audio with SMPTE channel
order. Fix ALSA a52 plugin to use that order when built against such a
libavcodec. Minor version of libavcodec was raised on the same day (Apr
17th 2009), so use that for the check.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 a52/pcm_a52.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 1abfdaa..b95d7d4 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -170,7 +170,13 @@ static int fill_data(snd_pcm_ioplug_t *io,
 		static unsigned int ch_index[3][6] = {
 			{ 0, 1 },
 			{ 0, 1, 2, 3 },
+#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 26)
+			/* current libavcodec expects SMPTE order */
+			{ 0, 1, 4, 5, 2, 3 },
+#else
+			/* libavcodec older than r18540 expects A52 order */
 			{ 0, 4, 1, 2, 3, 5 },
+#endif
 		};
 		/* flatten copy to n-channel interleaved */
 		dst_step = io->channels;
-- 
1.6.4.4
