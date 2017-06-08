From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/31] ALSA: intel8x0: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:43 +0200
Message-ID: <20170608210852.13058-23-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E00C2673C2
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:09:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B9975ADB9
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
 sound/pci/intel8x0.c  | 12 ++++++------
 sound/pci/intel8x0m.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 6d17b171c17b..a8d7092e93dd 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1136,31 +1136,31 @@ static struct snd_pcm_hardware snd_intel8x0_stream =
 	.fifo_size =		0,
 };
 
-static unsigned int channels4[] = {
+static const unsigned int channels4[] = {
 	2, 4,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_channels4 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels4 = {
 	.count = ARRAY_SIZE(channels4),
 	.list = channels4,
 	.mask = 0,
 };
 
-static unsigned int channels6[] = {
+static const unsigned int channels6[] = {
 	2, 4, 6,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_channels6 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels6 = {
 	.count = ARRAY_SIZE(channels6),
 	.list = channels6,
 	.mask = 0,
 };
 
-static unsigned int channels8[] = {
+static const unsigned int channels8[] = {
 	2, 4, 6, 8,
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_channels8 = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_channels8 = {
 	.count = ARRAY_SIZE(channels8),
 	.list = channels8,
 	.mask = 0,
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 1bc98c867133..18ff668ce7a5 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -635,8 +635,8 @@ static struct snd_pcm_hardware snd_intel8x0m_stream =
 
 static int snd_intel8x0m_pcm_open(struct snd_pcm_substream *substream, struct ichdev *ichdev)
 {
-	static unsigned int rates[] = { 8000,  9600, 12000, 16000 };
-	static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	static const unsigned int rates[] = { 8000,  9600, 12000, 16000 };
+	static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 		.count = ARRAY_SIZE(rates),
 		.list = rates,
 		.mask = 0,
-- 
2.13.0
