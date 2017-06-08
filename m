From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/31] ALSA: ens137x: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:38 +0200
Message-ID: <20170608210852.13058-18-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A1D42673C0
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CAB0DADD7
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 21:08:56 +0000 (UTC)
In-Reply-To: <20170608210852.13058-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ens1370.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 09a63ef41ef2..f0d978e3b274 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -467,41 +467,41 @@ MODULE_DEVICE_TABLE(pci, snd_audiopci_ids);
 #define POLL_COUNT	0xa000
 
 #ifdef CHIP1370
-static unsigned int snd_es1370_fixed_rates[] =
+static const unsigned int snd_es1370_fixed_rates[] =
 	{5512, 11025, 22050, 44100};
-static struct snd_pcm_hw_constraint_list snd_es1370_hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list snd_es1370_hw_constraints_rates = {
 	.count = 4, 
 	.list = snd_es1370_fixed_rates,
 	.mask = 0,
 };
-static struct snd_ratnum es1370_clock = {
+static const struct snd_ratnum es1370_clock = {
 	.num = ES_1370_SRCLOCK,
 	.den_min = 29, 
 	.den_max = 353,
 	.den_step = 1,
 };
-static struct snd_pcm_hw_constraint_ratnums snd_es1370_hw_constraints_clock = {
+static const struct snd_pcm_hw_constraint_ratnums snd_es1370_hw_constraints_clock = {
 	.nrats = 1,
 	.rats = &es1370_clock,
 };
 #else
-static struct snd_ratden es1371_dac_clock = {
+static const struct snd_ratden es1371_dac_clock = {
 	.num_min = 3000 * (1 << 15),
 	.num_max = 48000 * (1 << 15),
 	.num_step = 3000,
 	.den = 1 << 15,
 };
-static struct snd_pcm_hw_constraint_ratdens snd_es1371_hw_constraints_dac_clock = {
+static const struct snd_pcm_hw_constraint_ratdens snd_es1371_hw_constraints_dac_clock = {
 	.nrats = 1,
 	.rats = &es1371_dac_clock,
 };
-static struct snd_ratnum es1371_adc_clock = {
+static const struct snd_ratnum es1371_adc_clock = {
 	.num = 48000 << 15,
 	.den_min = 32768, 
 	.den_max = 393216,
 	.den_step = 1,
 };
-static struct snd_pcm_hw_constraint_ratnums snd_es1371_hw_constraints_adc_clock = {
+static const struct snd_pcm_hw_constraint_ratnums snd_es1371_hw_constraints_adc_clock = {
 	.nrats = 1,
 	.rats = &es1371_adc_clock,
 };
-- 
2.13.0
