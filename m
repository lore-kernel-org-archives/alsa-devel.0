From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/31] ALSA: nm256: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:44 +0200
Message-ID: <20170608210852.13058-24-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1932673C5
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C5404ADC6
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
 sound/pci/nm256/nm256.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 63f0985dae27..0ef8054c3936 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -398,10 +398,10 @@ snd_nm256_load_coefficient(struct nm256 *chip, int stream, int number)
 
 
 /* The actual rates supported by the card. */
-static unsigned int samplerates[8] = {
+static const unsigned int samplerates[8] = {
 	8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000,
 };
-static struct snd_pcm_hw_constraint_list constraints_rates = {
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
 	.count = ARRAY_SIZE(samplerates), 
 	.list = samplerates,
 	.mask = 0,
-- 
2.13.0
