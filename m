From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/31] ALSA: cs423x: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:22 +0200
Message-ID: <20170608210852.13058-2-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B353266847
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5CBC1AC9C
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
 sound/isa/cs423x/cs4236_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index 2b7cc596f4c6..2012936f6756 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -138,7 +138,7 @@ static unsigned char snd_cs4236_ctrl_in(struct snd_wss *chip, unsigned char reg)
 
 #define CLOCKS 8
 
-static struct snd_ratnum clocks[CLOCKS] = {
+static const struct snd_ratnum clocks[CLOCKS] = {
 	{ .num = 16934400, .den_min = 353, .den_max = 353, .den_step = 1 },
 	{ .num = 16934400, .den_min = 529, .den_max = 529, .den_step = 1 },
 	{ .num = 16934400, .den_min = 617, .den_max = 617, .den_step = 1 },
@@ -149,7 +149,7 @@ static struct snd_ratnum clocks[CLOCKS] = {
 	{ .num = 16934400/16, .den_min = 21, .den_max = 192, .den_step = 1 }
 };
 
-static struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks = {
+static const struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks = {
 	.nrats = CLOCKS,
 	.rats = clocks,
 };
-- 
2.13.0
