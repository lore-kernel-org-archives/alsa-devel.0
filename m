From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/31] ALSA: es1938: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:39 +0200
Message-ID: <20170608210852.13058-19-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 453B72673B9
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AA73BADB1
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
 sound/pci/es1938.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index a544cd52f73a..069902a06f00 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -436,7 +436,7 @@ static void snd_es1938_reset_fifo(struct es1938 *chip)
 	outb(0, SLSB_REG(chip, RESET));
 }
 
-static struct snd_ratnum clocks[2] = {
+static const struct snd_ratnum clocks[2] = {
 	{
 		.num = 793800,
 		.den_min = 1,
@@ -451,7 +451,7 @@ static struct snd_ratnum clocks[2] = {
 	}
 };
 
-static struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks = {
+static const struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks = {
 	.nrats = 2,
 	.rats = clocks,
 };
-- 
2.13.0
