From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ASoC: cs53l30: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:20 +0200
Message-ID: <20170608213725.5378-3-tiwai@suse.de>
References: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC982673D9
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:37:33 +0200 (CEST)
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
 sound/soc/codecs/cs53l30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 1e0d5973b758..06933a5d0a75 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -747,7 +747,7 @@ static unsigned int const cs53l30_src_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
 };
 
-static struct snd_pcm_hw_constraint_list src_constraints = {
+static const struct snd_pcm_hw_constraint_list src_constraints = {
 	.count = ARRAY_SIZE(cs53l30_src_rates),
 	.list = cs53l30_src_rates,
 };
-- 
2.13.0
