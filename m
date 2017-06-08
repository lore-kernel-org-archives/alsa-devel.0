From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 26/31] ALSA: hdsp: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:47 +0200
Message-ID: <20170608210852.13058-27-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 685932673BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CA275ADCF
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
 sound/pci/rme9652/hdsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index b00009644e0e..fe36d44d16c6 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4270,17 +4270,17 @@ static struct snd_pcm_hardware snd_hdsp_capture_subinfo =
 	.fifo_size =		0
 };
 
-static unsigned int hdsp_period_sizes[] = { 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
+static const unsigned int hdsp_period_sizes[] = { 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
 
-static struct snd_pcm_hw_constraint_list hdsp_hw_constraints_period_sizes = {
+static const struct snd_pcm_hw_constraint_list hdsp_hw_constraints_period_sizes = {
 	.count = ARRAY_SIZE(hdsp_period_sizes),
 	.list = hdsp_period_sizes,
 	.mask = 0
 };
 
-static unsigned int hdsp_9632_sample_rates[] = { 32000, 44100, 48000, 64000, 88200, 96000, 128000, 176400, 192000 };
+static const unsigned int hdsp_9632_sample_rates[] = { 32000, 44100, 48000, 64000, 88200, 96000, 128000, 176400, 192000 };
 
-static struct snd_pcm_hw_constraint_list hdsp_hw_constraints_9632_sample_rates = {
+static const struct snd_pcm_hw_constraint_list hdsp_hw_constraints_9632_sample_rates = {
 	.count = ARRAY_SIZE(hdsp_9632_sample_rates),
 	.list = hdsp_9632_sample_rates,
 	.mask = 0
-- 
2.13.0
