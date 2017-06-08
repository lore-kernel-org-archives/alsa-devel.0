From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/31] ALSA: hdspm: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:48 +0200
Message-ID: <20170608210852.13058-28-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 698012673BF
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CAA7CADD5
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
 sound/pci/rme9652/hdspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index c48acdb0e186..254c3d040118 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6040,11 +6040,11 @@ static int snd_hdspm_hw_rule_out_channels(struct snd_pcm_hw_params *params,
 }
 
 
-static unsigned int hdspm_aes32_sample_rates[] = {
+static const unsigned int hdspm_aes32_sample_rates[] = {
 	32000, 44100, 48000, 64000, 88200, 96000, 128000, 176400, 192000
 };
 
-static struct snd_pcm_hw_constraint_list
+static const struct snd_pcm_hw_constraint_list
 hdspm_hw_constraints_aes32_sample_rates = {
 	.count = ARRAY_SIZE(hdspm_aes32_sample_rates),
 	.list = hdspm_aes32_sample_rates,
-- 
2.13.0
