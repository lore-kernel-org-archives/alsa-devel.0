From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/31] ALSA: cmipci: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:34 +0200
Message-ID: <20170608210852.13058-14-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 443AF2673B5
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A746CAD93
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
 sound/pci/cmipci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 745a0a3743b4..a460cb63e971 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -719,18 +719,18 @@ static int snd_cmipci_hw_free(struct snd_pcm_substream *substream)
 /*
  */
 
-static unsigned int hw_channels[] = {1, 2, 4, 6, 8};
-static struct snd_pcm_hw_constraint_list hw_constraints_channels_4 = {
+static const unsigned int hw_channels[] = {1, 2, 4, 6, 8};
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels_4 = {
 	.count = 3,
 	.list = hw_channels,
 	.mask = 0,
 };
-static struct snd_pcm_hw_constraint_list hw_constraints_channels_6 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels_6 = {
 	.count = 4,
 	.list = hw_channels,
 	.mask = 0,
 };
-static struct snd_pcm_hw_constraint_list hw_constraints_channels_8 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels_8 = {
 	.count = 5,
 	.list = hw_channels,
 	.mask = 0,
@@ -1597,9 +1597,9 @@ static struct snd_pcm_hardware snd_cmipci_capture_spdif =
 	.fifo_size =		0,
 };
 
-static unsigned int rate_constraints[] = { 5512, 8000, 11025, 16000, 22050,
+static const unsigned int rate_constraints[] = { 5512, 8000, 11025, 16000, 22050,
 			32000, 44100, 48000, 88200, 96000, 128000 };
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 		.count = ARRAY_SIZE(rate_constraints),
 		.list = rate_constraints,
 		.mask = 0,
-- 
2.13.0
