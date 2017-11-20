From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH] pcm: route: Fix use_getput flag
 computation for 3 byte formats
Date: Mon, 20 Nov 2017 13:12:32 +0100
Message-ID: <450a039b-3038-f240-cdca-acafdfbb3b33@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A7B266D61
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 13:12:34 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit de63b942acf520 ("pcm: route: Use get/put labels for all 3 byte formats")
wanted to make the route plugin use get / put labels not only for 24-bit
physical width formats but also for 18 and 20-bit ones.
There was, however, a typo in that commit so a check for these widths
didn't really work.

Let's fix it now.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 src/pcm/pcm_route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 999a2eed3a25..1f485a8e79f9 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -567,8 +567,8 @@ static int snd_pcm_route_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		return err;
 	/* 3 bytes formats? */
 	route->params.use_getput =
-		(snd_pcm_format_physical_width(src_format) + 7) / 3 == 3 ||
-		(snd_pcm_format_physical_width(dst_format) + 7) / 3 == 3;
+		(snd_pcm_format_physical_width(src_format) + 7) / 8 == 3 ||
+		(snd_pcm_format_physical_width(dst_format) + 7) / 8 == 3;
 	route->params.get_idx = snd_pcm_linear_get_index(src_format, SND_PCM_FORMAT_S32);
 	route->params.put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, dst_format);
 	route->params.conv_idx = snd_pcm_linear_convert_index(src_format, dst_format);
-- 
2.14.1
