From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/31] ALSA: rme32: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:45 +0200
Message-ID: <20170608210852.13058-25-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E61D2673C3
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C2563ADBD
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
 sound/pci/rme32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 67d48c8869e9..e4cdef94e4a2 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -836,10 +836,9 @@ static irqreturn_t snd_rme32_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static unsigned int period_bytes[] = { RME32_BLOCK_SIZE };
+static const unsigned int period_bytes[] = { RME32_BLOCK_SIZE };
 
-
-static struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
 	.count = ARRAY_SIZE(period_bytes),
 	.list = period_bytes,
 	.mask = 0
-- 
2.13.0
