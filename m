From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/31] ALSA: via82xx: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:51 +0200
Message-ID: <20170608210852.13058-31-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 92EEA2673C8
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DABFCADE7
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
 sound/pci/via82xx.c       | 4 ++--
 sound/pci/via82xx_modem.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index b6c84d15b10b..c767b8664359 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1286,10 +1286,10 @@ static int snd_via8233_multi_open(struct snd_pcm_substream *substream)
 	/* channels constraint for VIA8233A
 	 * 3 and 5 channels are not supported
 	 */
-	static unsigned int channels[] = {
+	static const unsigned int channels[] = {
 		1, 2, 4, 6
 	};
-	static struct snd_pcm_hw_constraint_list hw_constraints_channels = {
+	static const struct snd_pcm_hw_constraint_list hw_constraints_channels = {
 		.count = ARRAY_SIZE(channels),
 		.list = channels,
 		.mask = 0,
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 2f6d40f10618..55f79b2599e7 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -744,8 +744,8 @@ static int snd_via82xx_modem_pcm_open(struct via82xx_modem *chip, struct viadev
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
-        static unsigned int rates[] = { 8000,  9600, 12000, 16000 };
-        static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	static const unsigned int rates[] = { 8000,  9600, 12000, 16000 };
+	static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
                 .count = ARRAY_SIZE(rates),
                 .list = rates,
                 .mask = 0,
-- 
2.13.0
