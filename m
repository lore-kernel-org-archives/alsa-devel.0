From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 29/31] ALSA: sonicvibes: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:50 +0200
Message-ID: <20170608210852.13058-30-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 938382673C9
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DF5A5ADEA
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
 sound/pci/sonicvibes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 8e3d4ec39c35..784d762f18a7 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -248,13 +248,13 @@ static const struct pci_device_id snd_sonic_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, snd_sonic_ids);
 
-static struct snd_ratden sonicvibes_adc_clock = {
+static const struct snd_ratden sonicvibes_adc_clock = {
 	.num_min = 4000 * 65536,
 	.num_max = 48000UL * 65536,
 	.num_step = 1,
 	.den = 65536,
 };
-static struct snd_pcm_hw_constraint_ratdens snd_sonicvibes_hw_constraints_adc_clock = {
+static const struct snd_pcm_hw_constraint_ratdens snd_sonicvibes_hw_constraints_adc_clock = {
 	.nrats = 1,
 	.rats = &sonicvibes_adc_clock,
 };
-- 
2.13.0
