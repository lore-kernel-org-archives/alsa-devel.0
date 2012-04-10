From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm9712: Fix build due to missing
	definition of "runtime"
Date: Tue, 10 Apr 2012 18:33:07 -0300
Message-ID: <1334093587-18184-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA9BE104087
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:33:18 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so193862yhn.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 14:33:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix the following build error:

sound/soc/codecs/wm9712.c:482:32: error: 'runtime' undeclared (first use in this function)
sound/soc/codecs/wm9712.c:499:33: error: 'runtime' undeclared (first use in this function)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm9712.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 2603863..a154141 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -470,6 +470,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	int reg;
 	u16 vra;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
 	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
@@ -487,6 +488,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 vra, xsle;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
 	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
-- 
1.7.1
