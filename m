From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/31] ALSA: sb: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:26 +0200
Message-ID: <20170608210852.13058-6-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F30426732A
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7DD5AAD54
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
 sound/isa/sb/sb8_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 9043397fe62f..0f302be4fb6d 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -46,19 +46,19 @@ MODULE_LICENSE("GPL");
 #define SB8_DEN(v)	((SB8_CLOCK + (v) / 2) / (v))
 #define SB8_RATE(v)	(SB8_CLOCK / SB8_DEN(v))
 
-static struct snd_ratnum clock = {
+static const struct snd_ratnum clock = {
 	.num = SB8_CLOCK,
 	.den_min = 1,
 	.den_max = 256,
 	.den_step = 1,
 };
 
-static struct snd_pcm_hw_constraint_ratnums hw_constraints_clock = {
+static const struct snd_pcm_hw_constraint_ratnums hw_constraints_clock = {
 	.nrats = 1,
 	.rats = &clock,
 };
 
-static struct snd_ratnum stereo_clocks[] = {
+static const struct snd_ratnum stereo_clocks[] = {
 	{
 		.num = SB8_CLOCK,
 		.den_min = SB8_DEN(22050),
-- 
2.13.0
