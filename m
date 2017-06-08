From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/31] ALSA: bt87x: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:33 +0200
Message-ID: <20170608210852.13058-13-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5972E2673AD
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9CF3BAD87
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
 sound/pci/bt87x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 099efb046b1c..de0234294c25 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -401,13 +401,13 @@ static int snd_bt87x_set_digital_hw(struct snd_bt87x *chip, struct snd_pcm_runti
 
 static int snd_bt87x_set_analog_hw(struct snd_bt87x *chip, struct snd_pcm_runtime *runtime)
 {
-	static struct snd_ratnum analog_clock = {
+	static const struct snd_ratnum analog_clock = {
 		.num = ANALOG_CLOCK,
 		.den_min = CLOCK_DIV_MIN,
 		.den_max = CLOCK_DIV_MAX,
 		.den_step = 1
 	};
-	static struct snd_pcm_hw_constraint_ratnums constraint_rates = {
+	static const struct snd_pcm_hw_constraint_ratnums constraint_rates = {
 		.nrats = 1,
 		.rats = &analog_clock
 	};
-- 
2.13.0
