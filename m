From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/31] ALSA: fm801: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:37 +0200
Message-ID: <20170608210852.13058-17-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B412673B4
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A92DAADB0
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
 sound/pci/fm801.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c47287d79306..2e402ece4c86 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -334,23 +334,23 @@ static unsigned short snd_fm801_codec_read(struct snd_ac97 *ac97, unsigned short
 	return fm801_readw(chip, AC97_DATA);
 }
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
   5500,  8000,  9600, 11025,
   16000, 19200, 22050, 32000,
   38400, 44100, 48000
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
 };
 
-static unsigned int channels[] = {
+static const unsigned int channels[] = {
   2, 4, 6
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_channels = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels = {
 	.count = ARRAY_SIZE(channels),
 	.list = channels,
 	.mask = 0,
-- 
2.13.0
