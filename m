From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/31] ALSA: cs46xx: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:35 +0200
Message-ID: <20170608210852.13058-15-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8042673B0
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9EFA9AD8B
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
 sound/pci/cs46xx/cs46xx_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index ae2aad52ea6f..709fb1a503b7 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1482,9 +1482,9 @@ static struct snd_pcm_hardware snd_cs46xx_capture =
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
-static unsigned int period_sizes[] = { 32, 64, 128, 256, 512, 1024, 2048 };
+static const unsigned int period_sizes[] = { 32, 64, 128, 256, 512, 1024, 2048 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_period_sizes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_period_sizes = {
 	.count = ARRAY_SIZE(period_sizes),
 	.list = period_sizes,
 	.mask = 0
-- 
2.13.0
