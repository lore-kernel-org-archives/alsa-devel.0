From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/31] ALSA: parisc: Constify hw_constraints
Date: Thu,  8 Jun 2017 23:08:28 +0200
Message-ID: <20170608210852.13058-8-tiwai@suse.de>
References: <20170608210852.13058-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB11267339
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 23:08:59 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7D08AAD24
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
 sound/parisc/harmony.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 99b64cb3cef8..5911eb35c2a3 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -83,14 +83,14 @@ MODULE_DEVICE_TABLE(parisc, snd_harmony_devtable);
 #define NAME "harmony"
 #define PFX  NAME ": "
 
-static unsigned int snd_harmony_rates[] = {
+static const unsigned int snd_harmony_rates[] = {
 	5512, 6615, 8000, 9600,
 	11025, 16000, 18900, 22050,
 	27428, 32000, 33075, 37800,
 	44100, 48000
 };
 
-static unsigned int rate_bits[14] = {
+static const unsigned int rate_bits[14] = {
 	HARMONY_SR_5KHZ, HARMONY_SR_6KHZ, HARMONY_SR_8KHZ,
 	HARMONY_SR_9KHZ, HARMONY_SR_11KHZ, HARMONY_SR_16KHZ,
 	HARMONY_SR_18KHZ, HARMONY_SR_22KHZ, HARMONY_SR_27KHZ,
@@ -98,7 +98,7 @@ static unsigned int rate_bits[14] = {
 	HARMONY_SR_44KHZ, HARMONY_SR_48KHZ
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraint_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraint_rates = {
 	.count = ARRAY_SIZE(snd_harmony_rates),
 	.list = snd_harmony_rates,
 	.mask = 0,
-- 
2.13.0
