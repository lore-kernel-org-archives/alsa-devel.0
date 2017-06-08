From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ASoC: mediatek: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:24 +0200
Message-ID: <20170608213725.5378-7-tiwai@suse.de>
References: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A41A267342
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:34 +0200 (CEST)
In-Reply-To: <20170608213725.5378-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index aa5b31b121e3..70f61d53fe05 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -107,7 +107,7 @@ static const struct snd_kcontrol_new mt2701_cs42448_controls[] = {
 
 static const unsigned int mt2701_cs42448_sampling_rates[] = {48000};
 
-static struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
 		.count = ARRAY_SIZE(mt2701_cs42448_sampling_rates),
 		.list = mt2701_cs42448_sampling_rates,
 		.mask = 0,
-- 
2.13.0
