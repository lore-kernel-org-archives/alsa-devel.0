From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/31] ALSA: atiixp: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:30 +0200
Message-ID: <20170608210852.13058-10-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 309D526739D
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7F436AD5C
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
 sound/pci/atiixp_modem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 40152feef1e7..52e0ea7b9b80 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -860,8 +860,8 @@ static int snd_atiixp_pcm_open(struct snd_pcm_substream *substream,
 	struct atiixp_modem *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
-	static unsigned int rates[] = { 8000,  9600, 12000, 16000 };
-	static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	static const unsigned int rates[] = { 8000,  9600, 12000, 16000 };
+	static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 		.count = ARRAY_SIZE(rates),
 		.list = rates,
 		.mask = 0,
-- 
2.13.0
