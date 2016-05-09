From: John Keeping <john@metanate.com>
Subject: [PATCH 9/9] ASoC: es8328: Set symmetric rates
Date: Mon,  9 May 2016 12:24:37 +0100
Message-ID: <20160509112437.8924-10-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B4A3F2651D1
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 13:24:48 +0200 (CEST)
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

Although the ES8328 does support different rates for capture and
playback, only very limited combinations are supported (8kHz and 48kHz
or 8.0182kHz and 44.1kHz) with most rates required to be symmetric.

Instead of adding a lot of complexity for little gain, let's enforce
symmetric rates.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 6ec15c8822d3..26d46e5cb402 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -703,6 +703,7 @@ static struct snd_soc_dai_driver es8328_dai = {
 		.formats = ES8328_FORMATS,
 	},
 	.ops = &es8328_dai_ops,
+	.symmetric_rates = 1,
 };
 
 static int es8328_suspend(struct snd_soc_codec *codec)
-- 
2.8.0.rc4.238.g874082a
