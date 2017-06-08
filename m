From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 28/31] ALSA: rme9652: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:49 +0200
Message-ID: <20170608210852.13058-29-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C902673C6
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D0692ADDA
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
 sound/pci/rme9652/rme9652.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 59684bf5cac0..150d08898db8 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2228,9 +2228,9 @@ static struct snd_pcm_hardware snd_rme9652_capture_subinfo =
 	.fifo_size =		0,
 };
 
-static unsigned int period_sizes[] = { 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
+static const unsigned int period_sizes[] = { 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_period_sizes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_period_sizes = {
 	.count = ARRAY_SIZE(period_sizes),
 	.list = period_sizes,
 	.mask = 0
-- 
2.13.0
