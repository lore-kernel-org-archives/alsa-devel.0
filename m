From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/31] ALSA: azt3328: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:32 +0200
Message-ID: <20170608210852.13058-12-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A1F92673AF
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 95BE6AD78
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
 sound/pci/azt3328.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 79b2e6b7d88b..fc18c29a8173 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2014,7 +2014,7 @@ static const struct snd_pcm_hardware snd_azf3328_hardware =
 };
 
 
-static unsigned int snd_azf3328_fixed_rates[] = {
+static const unsigned int snd_azf3328_fixed_rates[] = {
 	AZF_FREQ_4000,
 	AZF_FREQ_4800,
 	AZF_FREQ_5512,
@@ -2031,7 +2031,7 @@ static unsigned int snd_azf3328_fixed_rates[] = {
 	AZF_FREQ_66200
 };
 
-static struct snd_pcm_hw_constraint_list snd_azf3328_hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list snd_azf3328_hw_constraints_rates = {
 	.count = ARRAY_SIZE(snd_azf3328_fixed_rates),
 	.list = snd_azf3328_fixed_rates,
 	.mask = 0,
-- 
2.13.0
