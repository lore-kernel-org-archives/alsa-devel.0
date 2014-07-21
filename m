From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: route: Use get/put labels for all 3 byte
	formats
Date: Mon, 21 Jul 2014 16:33:49 +0200
Message-ID: <1405953229-9948-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 501C3261A33
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 16:33:50 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E741DAC97
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 14:33:49 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So far, use_getput flag is set only when the src or dest format is
24bit physical width.  But, also 18 and 20 bit physical width formats
should set the flag, too.  This patch makes the check broader to cover
all 3 bytes formats.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_route.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 2f0be38b1906..72c198cb25d2 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -644,8 +644,10 @@ static int snd_pcm_route_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	}
 	if (err < 0)
 		return err;
-	route->params.use_getput = snd_pcm_format_physical_width(src_format) == 24 ||
-		snd_pcm_format_physical_width(dst_format) == 24;
+	/* 3 bytes formats? */
+	route->params.use_getput =
+		(snd_pcm_format_physical_width(src_format) + 7) / 3 == 3 ||
+		(snd_pcm_format_physical_width(dst_format) + 7) / 3 == 3;
 	route->params.get_idx = snd_pcm_linear_get_index(src_format, SND_PCM_FORMAT_S16);
 	route->params.put_idx = snd_pcm_linear_put32_index(SND_PCM_FORMAT_S32, dst_format);
 	route->params.conv_idx = snd_pcm_linear_convert_index(src_format, dst_format);
-- 
2.0.1
