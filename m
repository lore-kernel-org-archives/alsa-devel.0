From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/31] ALSA: gus: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:25 +0200
Message-ID: <20170608210852.13058-5-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FE47266A11
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:56 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5F955ACBF
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
 sound/isa/gus/gus_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index b9f6dcbef889..6b3da01a93b7 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -562,14 +562,14 @@ static snd_pcm_uframes_t snd_gf1_pcm_playback_pointer(struct snd_pcm_substream *
 	return pos;
 }
 
-static struct snd_ratnum clock = {
+static const struct snd_ratnum clock = {
 	.num = 9878400/16,
 	.den_min = 2,
 	.den_max = 257,
 	.den_step = 1,
 };
 
-static struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks  = {
+static const struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks  = {
 	.nrats = 1,
 	.rats = &clock,
 };
-- 
2.13.0
