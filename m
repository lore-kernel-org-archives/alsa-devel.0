From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/31] ALSA: au88x0: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:31 +0200
Message-ID: <20170608210852.13058-11-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 59C352673AE
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8B517AD77
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
 sound/pci/au88x0/au88x0_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index 335979a753fe..1aa97012451d 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -112,11 +112,11 @@ static struct snd_pcm_hardware snd_vortex_playback_hw_wt = {
 };
 #endif
 #ifdef CHIP_AU8830
-static unsigned int au8830_channels[3] = {
+static const unsigned int au8830_channels[3] = {
 	1, 2, 4,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_au8830_channels = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_au8830_channels = {
 	.count = ARRAY_SIZE(au8830_channels),
 	.list = au8830_channels,
 	.mask = 0,
-- 
2.13.0
