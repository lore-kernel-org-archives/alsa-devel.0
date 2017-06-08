From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/31] ALSA: es18xx: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:24 +0200
Message-ID: <20170608210852.13058-4-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC362668BF
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 56BBDAC03
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
 sound/isa/es18xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 0cabe2b8974f..ae17a6584061 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -369,7 +369,7 @@ static int snd_es18xx_reset_fifo(struct snd_es18xx *chip)
 	return 0;
 }
 
-static struct snd_ratnum new_clocks[2] = {
+static const struct snd_ratnum new_clocks[2] = {
 	{
 		.num = 793800,
 		.den_min = 1,
@@ -384,12 +384,12 @@ static struct snd_ratnum new_clocks[2] = {
 	}
 };
 
-static struct snd_pcm_hw_constraint_ratnums new_hw_constraints_clocks = {
+static const struct snd_pcm_hw_constraint_ratnums new_hw_constraints_clocks = {
 	.nrats = 2,
 	.rats = new_clocks,
 };
 
-static struct snd_ratnum old_clocks[2] = {
+static const struct snd_ratnum old_clocks[2] = {
 	{
 		.num = 795444,
 		.den_min = 1,
@@ -404,7 +404,7 @@ static struct snd_ratnum old_clocks[2] = {
 	}
 };
 
-static struct snd_pcm_hw_constraint_ratnums old_hw_constraints_clocks  = {
+static const struct snd_pcm_hw_constraint_ratnums old_hw_constraints_clocks  = {
 	.nrats = 2,
 	.rats = old_clocks,
 };
-- 
2.13.0
