From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH 4/4] pcm: plug: add SND_PCM_FORMAT_{S,
 U}20 to linear_preferred_formats
Date: Wed, 29 Nov 2017 23:17:51 +0100
Message-ID: <43cb4e59-50c3-436c-b7bb-c66bed1d9c7e@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF63267A53
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 23:17:53 +0100 (CET)
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

This commit adds the recently added formats SND_PCM_FORMAT_{S,U}20 to
the linear_preferred_formats array in pcm_plug.
Let's give them lower priority than more standard S24 formats but a higher
priority than less typical 3-byte versions.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 src/pcm/pcm_plug.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index f1d7792db709..abf6f1ab9751 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -138,6 +138,17 @@ static const snd_pcm_format_t linear_preferred_formats[] = {
 	SND_PCM_FORMAT_S24_LE,
 	SND_PCM_FORMAT_U24_LE,
 #endif
+#ifdef SND_LITTLE_ENDIAN
+	SND_PCM_FORMAT_S20_LE,
+	SND_PCM_FORMAT_U20_LE,
+	SND_PCM_FORMAT_S20_BE,
+	SND_PCM_FORMAT_U20_BE,
+#else
+	SND_PCM_FORMAT_S20_BE,
+	SND_PCM_FORMAT_U20_BE,
+	SND_PCM_FORMAT_S20_LE,
+	SND_PCM_FORMAT_U20_LE,
+#endif
 #ifdef SND_LITTLE_ENDIAN
 	SND_PCM_FORMAT_S24_3LE,
 	SND_PCM_FORMAT_U24_3LE,
