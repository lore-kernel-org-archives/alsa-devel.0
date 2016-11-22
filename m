From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Make return type of dpcm_state_string()
	const char *
Date: Tue, 22 Nov 2016 11:29:14 +0100
Message-ID: <1479810554-24289-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EF90266801
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 11:29:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

dpcm_state_string() returns a pointer to a string literal. Modifying a
string literal causes undefined behaviour. So make the return type of the
function const char * to make it explicit that the returned value should
not be modified.

This patch is purely cosmetic, none of the users of dpcm_state_string()
attempt to modify the returned content.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d56a16a..e7a1eaa 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2882,7 +2882,7 @@ int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_soc_platform_trigger);
 
 #ifdef CONFIG_DEBUG_FS
-static char *dpcm_state_string(enum snd_soc_dpcm_state state)
+static const char *dpcm_state_string(enum snd_soc_dpcm_state state)
 {
 	switch (state) {
 	case SND_SOC_DPCM_STATE_NEW:
-- 
2.1.4
