From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/31] ALSA: ice1712: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:41 +0200
Message-ID: <20170608210852.13058-21-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C122673B7
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AFAEFADB5
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
 sound/pci/ice1712/ice1712.c | 4 ++--
 sound/pci/ice1712/ice1712.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 6b650ab2a084..0e66afa403a3 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -932,10 +932,10 @@ static int snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device)
  *  PCM code - professional part (multitrack)
  */
 
-static unsigned int rates[] = { 8000, 9600, 11025, 12000, 16000, 22050, 24000,
+static const unsigned int rates[] = { 8000, 9600, 11025, 12000, 16000, 22050, 24000,
 				32000, 44100, 48000, 64000, 88200, 96000 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
diff --git a/sound/pci/ice1712/ice1712.h b/sound/pci/ice1712/ice1712.h
index 58f8f2ae758d..5cfba09c9761 100644
--- a/sound/pci/ice1712/ice1712.h
+++ b/sound/pci/ice1712/ice1712.h
@@ -348,7 +348,7 @@ struct snd_ice1712 {
 
 	struct mutex open_mutex;
 	struct snd_pcm_substream *pcm_reserved[4];
-	struct snd_pcm_hw_constraint_list *hw_rates; /* card-specific rate constraints */
+	const struct snd_pcm_hw_constraint_list *hw_rates; /* card-specific rate constraints */
 
 	unsigned int akm_codecs;
 	struct snd_akm4xxx *akm;
-- 
2.13.0
