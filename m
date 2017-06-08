From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/31] ALSA: rme96: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:46 +0200
Message-ID: <20170608210852.13058-26-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 68DF72673BE
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D2A76ADE1
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
 sound/pci/rme96.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 24f1349a8e1b..2e19ba55e754 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1163,9 +1163,9 @@ snd_rme96_interrupt(int irq,
 	return IRQ_HANDLED;
 }
 
-static unsigned int period_bytes[] = { RME96_SMALL_BLOCK_SIZE, RME96_LARGE_BLOCK_SIZE };
+static const unsigned int period_bytes[] = { RME96_SMALL_BLOCK_SIZE, RME96_LARGE_BLOCK_SIZE };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
 	.count = ARRAY_SIZE(period_bytes),
 	.list = period_bytes,
 	.mask = 0
-- 
2.13.0
