From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: amd: make pointer da7219_dai_clk
	static
Date: Fri, 23 Mar 2018 09:48:24 +0000
Message-ID: <20180323094824.26028-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CBCC2673B2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 10:48:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Akshu Agrawal <akshu.agrawal@amd.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer da7219_dai_clk  is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/amd/acp-da7219-max98357a.c:46:12: warning: symbol 'da7219_dai_clk'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 99c6b5ce5c6c..af458bd36c72 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -43,7 +43,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.15.1
