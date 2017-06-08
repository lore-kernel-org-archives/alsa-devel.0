From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/31] ALSA: wss: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:27 +0200
Message-ID: <20170608210852.13058-7-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EB7C26725C
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7C953AD20
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
 sound/isa/wss/wss_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 913b731d2236..9f4e2e34cbe1 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -69,12 +69,12 @@ static unsigned char freq_bits[14] = {
 	/* 48000 */	0x0C | CS4231_XTAL1
 };
 
-static unsigned int rates[14] = {
+static const unsigned int rates[14] = {
 	5510, 6620, 8000, 9600, 11025, 16000, 18900, 22050,
 	27042, 32000, 33075, 37800, 44100, 48000
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
-- 
2.13.0
