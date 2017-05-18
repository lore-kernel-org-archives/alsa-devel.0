From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ALSA: pcm/oss: mark
	snd_pcm_plug_slave_format arg as const
Date: Thu, 18 May 2017 15:35:55 +0200
Message-ID: <20170518133610.1914235-2-arnd@arndb.de>
References: <20170518133610.1914235-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AE52671B1
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 15:36:31 +0200 (CEST)
In-Reply-To: <20170518133610.1914235-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Only one of the two declarations has the const modifier in the
argument list, so we get a warning when CONFIG_SND_PCM_OSS_PLUGINS
is disabled:

sound/core/oss/pcm_oss.c: In function 'snd_pcm_oss_change_params':
sound/core/oss/pcm_oss.c:898:47: error: passing argument 2 of 'snd_pcm_plug_slave_format' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

This makes the two declarations match again.

Fixes: e76bf3c4b4e4 ("ALSA: pcm/oss: refer to parameters instead of copying to reduce usage of kernel stack")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/oss/pcm_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index 38e2c14cb893..73c068abaca5 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -172,7 +172,7 @@ snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
 
 static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
 static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
-static inline int snd_pcm_plug_slave_format(int format, struct snd_mask *format_mask) { return format; }
+static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
 
 #endif
 
-- 
2.9.0
