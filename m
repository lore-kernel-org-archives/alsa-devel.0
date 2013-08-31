From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: cq93vc: Don't use control data for
	core driver data
Date: Sat, 31 Aug 2013 14:08:58 +0100
Message-ID: <1377954539-7532-4-git-send-email-broonie@kernel.org>
References: <20130831130741.GG18608@sirena.org.uk>
 <1377954539-7532-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 58DBF261AE5
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 15:09:16 +0200 (CEST)
In-Reply-To: <1377954539-7532-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The platform data is being used to obtain the core driver data for the
device (which is a bit of an abuse but not the issue at hand) so reference
it directly in order to support refactoring to use regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cq93vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 424e9a4..2cbb584 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -81,7 +81,7 @@ static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct davinci_vc *davinci_vc = codec->control_data;
+	struct davinci_vc *davinci_vc = codec->dev->platform_data;
 
 	switch (freq) {
 	case 22579200:
-- 
1.8.4.rc3
