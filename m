From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH v3 4/4] pcm: plug: add
 SND_PCM_FORMAT_{S, U}20 to linear_preferred_formats
Date: Thu, 14 Dec 2017 14:54:29 +0100
Message-ID: <f3a74ca0-a602-ebe6-625c-03e2d77e2702@maciej.szmigiero.name>
References: <cover.1513257270.git.mail@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A81726732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 14:54:31 +0100 (CET)
In-Reply-To: <cover.1513257270.git.mail@maciej.szmigiero.name>
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
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
