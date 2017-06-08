From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/31] ALSA: emu10k1: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:36 +0200
Message-ID: <20170608210852.13058-16-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 434662673B2
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9F8C0AD8E
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
 sound/pci/emu10k1/emupcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index bdda29f335f6..5c9054a9f69e 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -164,7 +164,7 @@ static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm * epcm, int voic
 	return 0;
 }
 
-static unsigned int capture_period_sizes[31] = {
+static const unsigned int capture_period_sizes[31] = {
 	384,	448,	512,	640,
 	384*2,	448*2,	512*2,	640*2,
 	384*4,	448*4,	512*4,	640*4,
@@ -175,17 +175,17 @@ static unsigned int capture_period_sizes[31] = {
 	384*128,448*128,512*128
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_capture_period_sizes = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_capture_period_sizes = {
 	.count = 31,
 	.list = capture_period_sizes,
 	.mask = 0
 };
 
-static unsigned int capture_rates[8] = {
+static const unsigned int capture_rates[8] = {
 	8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_capture_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_capture_rates = {
 	.count = 8,
 	.list = capture_rates,
 	.mask = 0
-- 
2.13.0
