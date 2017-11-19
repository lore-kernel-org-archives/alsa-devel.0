From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] ASoC: soc-pcm: Improve a size
 determination in dpcm_be_connect()
Date: Sun, 19 Nov 2017 21:24:22 +0100
Message-ID: <72a5b41c-a1c2-2ca5-db74-c1f77b07ab73@users.sourceforge.net>
References: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id DE6BD266E76
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 21:24:28 +0100 (CET)
In-Reply-To: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 21:02:20 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fa2f7ccceacf..35b52cea5c89 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1308,7 +1308,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			return 0;
 	}
 
-	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
+	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (!dpcm)
 		return -ENOMEM;
 
-- 
2.15.0
