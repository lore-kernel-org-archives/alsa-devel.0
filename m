From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: ak4642: make arrays fs_list and ps_list
	static const
Date: Fri, 30 Jun 2017 10:16:36 +0100
Message-ID: <20170630091636.8287-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0440E266EB6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 11:17:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays fs_list and ps_list on the stack but make
them static const.  Makes the object code smaller:

Before:
   text    data     bss     dec     hex filename
  12084    4888      64   17036    428c sound/soc/codecs/ak4642.o

After:
   text    data     bss     dec     hex filename
  11883    5032      64   16979    4253 sound/soc/codecs/ak4642.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/ak4642.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 23ab9646c351..66de8a2013a6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -433,7 +433,7 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int ak4642_set_mcko(struct snd_soc_codec *codec,
 			   u32 frequency)
 {
-	u32 fs_list[] = {
+	static const u32 fs_list[] = {
 		[0] = 8000,
 		[1] = 12000,
 		[2] = 16000,
@@ -447,7 +447,7 @@ static int ak4642_set_mcko(struct snd_soc_codec *codec,
 		[14] = 29400,
 		[15] = 44100,
 	};
-	u32 ps_list[] = {
+	static const u32 ps_list[] = {
 		[0] = 256,
 		[1] = 128,
 		[2] = 64,
-- 
2.11.0
