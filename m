From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 36/53] ALSA: x86: Constfy tables
Date: Thu,  2 Feb 2017 18:02:50 +0100
Message-ID: <20170202170307.24484-38-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 425B0267598
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Some tables can be defined as const.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 84b374cc183f..81b6c26a8646 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(id,
 /*
  * ELD SA bits in the CEA Speaker Allocation data block
  */
-static int eld_speaker_allocation_bits[] = {
+static const int eld_speaker_allocation_bits[] = {
 	[0] = FL | FR,
 	[1] = LFE,
 	[2] = FC,
@@ -114,7 +114,7 @@ static struct cea_channel_speaker_allocation channel_allocations[] = {
 { .ca_index = 0x1f,  .speakers = { FRC,  FLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
 };
 
-static struct channel_map_table map_tables[] = {
+static const struct channel_map_table map_tables[] = {
 	{ SNDRV_CHMAP_FL,       0x00,   FL },
 	{ SNDRV_CHMAP_FR,       0x01,   FR },
 	{ SNDRV_CHMAP_RL,       0x04,   RL },
@@ -455,7 +455,7 @@ static int snd_intelhad_channel_allocation(struct snd_intelhad *intelhaddata,
 /* from speaker bit mask to ALSA API channel position */
 static int spk_to_chmap(int spk)
 {
-	struct channel_map_table *t = map_tables;
+	const struct channel_map_table *t = map_tables;
 
 	for (; t->map; t++) {
 		if (t->spk_mask == spk)
-- 
2.11.0
