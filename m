From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: Use struct_size() helper
Date: Thu, 23 May 2019 15:29:17 -0500
Message-ID: <20190523202917.GA12595@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.144.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68009F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 22:29:20 +0200 (CEST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 487287030
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 15:29:19 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct rate_priv) + src_format->channels * sizeof(struct rate_channel)

with:

struct_size(data, channels, src_format->channels)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/oss/rate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
index 2fa9299a440d..7cd09cef6961 100644
--- a/sound/core/oss/rate.c
+++ b/sound/core/oss/rate.c
@@ -323,8 +323,8 @@ int snd_pcm_plugin_build_rate(struct snd_pcm_substream *plug,
 
 	err = snd_pcm_plugin_build(plug, "rate conversion",
 				   src_format, dst_format,
-				   sizeof(struct rate_priv) +
-				   src_format->channels * sizeof(struct rate_channel),
+				   struct_size(data, channels,
+					       src_format->channels),
 				   &plugin);
 	if (err < 0)
 		return err;
-- 
2.21.0
