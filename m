From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/11] ASoC: dpcm: Allow PCMs to omit the
	set of supported formats
Date: Mon,  6 Jan 2014 14:19:07 +0100
Message-ID: <1389014356-7014-2-git-send-email-lars@metafoo.de>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 45F2126109E
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:18:55 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Allow PCMs that do not impose any restrictions on the supported formats to set
the formats field to 0, Instead of assuming that this means that the PCM does
not support any formats (which doesn't make much sense), assume that it supports
all formats. This brings the behavior of DPCM closer to that of non-DPCM.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>
---
New in v2
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 898149e..86b670e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1242,7 +1242,10 @@ static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 	runtime->hw.rate_max = stream->rate_max;
 	runtime->hw.channels_min = stream->channels_min;
 	runtime->hw.channels_max = stream->channels_max;
-	runtime->hw.formats &= stream->formats;
+	if (runtime->hw.formats)
+		runtime->hw.formats &= stream->formats;
+	else
+		runtime->hw.formats = stream->formats;
 	runtime->hw.rates = stream->rates;
 }
 
-- 
1.8.0
