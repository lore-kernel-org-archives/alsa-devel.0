From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ASoC: intel: byt: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:37:22 +0200
Message-ID: <20170608213725.5378-5-tiwai@suse.de>
References: <20170608213725.5378-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE3E2673C9
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
 sound/soc/intel/boards/bytcht_nocodec.c | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 89853eeaaf9d..1dd9441806fa 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -85,11 +85,11 @@ static int codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int rates_48000[] = {
+static const unsigned int rates_48000[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_48000 = {
+static const struct snd_pcm_hw_constraint_list constraints_48000 = {
 	.count = ARRAY_SIZE(rates_48000),
 	.list  = rates_48000,
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8164bec63bf1..4a3516b38c2c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -203,11 +203,11 @@ static int byt_rt5651_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int rates_48000[] = {
+static const unsigned int rates_48000[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_48000 = {
+static const struct snd_pcm_hw_constraint_list constraints_48000 = {
 	.count = ARRAY_SIZE(rates_48000),
 	.list  = rates_48000,
 };
-- 
2.13.0
