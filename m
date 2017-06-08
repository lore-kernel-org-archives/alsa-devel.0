From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/31] ALSA: ice1724: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:42 +0200
Message-ID: <20170608210852.13058-22-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DACA2673C1
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B161CADB6
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
 sound/pci/ice1712/ice1724.c | 8 ++++----
 sound/pci/ice1712/juli.c    | 6 +++---
 sound/pci/ice1712/maya44.c  | 4 ++--
 sound/pci/ice1712/quartet.c | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 785188140f6b..057c2f394ea7 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -521,25 +521,25 @@ static irqreturn_t snd_vt1724_interrupt(int irq, void *dev_id)
  *  PCM code - professional part (multitrack)
  */
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	8000, 9600, 11025, 12000, 16000, 22050, 24000,
 	32000, 44100, 48000, 64000, 88200, 96000,
 	176400, 192000,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates_96 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates_96 = {
 	.count = ARRAY_SIZE(rates) - 2, /* up to 96000 */
 	.list = rates,
 	.mask = 0,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates_48 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates_48 = {
 	.count = ARRAY_SIZE(rates) - 5, /* up to 48000 */
 	.list = rates,
 	.mask = 0,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates_192 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates_192 = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index 4f0213427152..5bb146703738 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -133,19 +133,19 @@ struct juli_spec {
 /*
  * Initial setup of the conversion array GPIO <-> rate
  */
-static unsigned int juli_rates[] = {
+static const unsigned int juli_rates[] = {
 	16000, 22050, 24000, 32000,
 	44100, 48000, 64000, 88200,
 	96000, 176400, 192000,
 };
 
-static unsigned int gpio_vals[] = {
+static const unsigned int gpio_vals[] = {
 	GPIO_RATE_16000, GPIO_RATE_22050, GPIO_RATE_24000, GPIO_RATE_32000,
 	GPIO_RATE_44100, GPIO_RATE_48000, GPIO_RATE_64000, GPIO_RATE_88200,
 	GPIO_RATE_96000, GPIO_RATE_176400, GPIO_RATE_192000,
 };
 
-static struct snd_pcm_hw_constraint_list juli_rates_info = {
+static const struct snd_pcm_hw_constraint_list juli_rates_info = {
 	.count = ARRAY_SIZE(juli_rates),
 	.list = juli_rates,
 	.mask = 0,
diff --git a/sound/pci/ice1712/maya44.c b/sound/pci/ice1712/maya44.c
index 7de25c4807fd..0e30419f6bbd 100644
--- a/sound/pci/ice1712/maya44.c
+++ b/sound/pci/ice1712/maya44.c
@@ -661,12 +661,12 @@ static void set_rate(struct snd_ice1712 *ice, unsigned int rate)
  * supported sample rates (to override the default one)
  */
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000
 };
 
 /* playback rates: 32..192 kHz */
-static struct snd_pcm_hw_constraint_list dac_rates = {
+static const struct snd_pcm_hw_constraint_list dac_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 7c387b04067e..f1b3732cc6d2 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -231,17 +231,17 @@ static char *get_binary(char *buffer, int value)
 /*
  * Initial setup of the conversion array GPIO <-> rate
  */
-static unsigned int qtet_rates[] = {
+static const unsigned int qtet_rates[] = {
 	44100, 48000, 88200,
 	96000, 176400, 192000,
 };
 
-static unsigned int cks_vals[] = {
+static const unsigned int cks_vals[] = {
 	CPLD_CKS_44100HZ, CPLD_CKS_48000HZ, CPLD_CKS_88200HZ,
 	CPLD_CKS_96000HZ, CPLD_CKS_176400HZ, CPLD_CKS_192000HZ,
 };
 
-static struct snd_pcm_hw_constraint_list qtet_rates_info = {
+static const struct snd_pcm_hw_constraint_list qtet_rates_info = {
 	.count = ARRAY_SIZE(qtet_rates),
 	.list = qtet_rates,
 	.mask = 0,
-- 
2.13.0
