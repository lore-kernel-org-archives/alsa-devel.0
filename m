From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max9867: Use params_width instead of
	open-coded
Date: Tue, 23 Feb 2016 14:53:13 +0800
Message-ID: <1456210393.15964.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E3512605B4
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 07:53:18 +0100 (CET)
Received: by mail-pf0-f180.google.com with SMTP id q63so106944426pfb.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 22:53:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max9867.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index ab7a94d..e3ee391 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -206,10 +206,9 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		unsigned long int bclk_rate, pclk_bclk_ratio;
 		int bclk_value;
 
-		bclk_rate = params_rate(params) * 2 *
-			snd_pcm_format_width(params_format(params));
+		bclk_rate = params_rate(params) * 2 * params_width(params);
 		pclk_bclk_ratio = max9867->pclk/bclk_rate;
-		switch (snd_pcm_format_width(params_format(params))) {
+		switch (params_width(params)) {
 		case 8:
 		case 16:
 			switch (pclk_bclk_ratio) {
-- 
2.1.4
