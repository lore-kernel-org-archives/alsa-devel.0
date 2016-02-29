From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hdspm: Fix wrong boolean ctl value
	accesses
Date: Mon, 29 Feb 2016 17:19:42 +0100
Message-ID: <1456762783-2653-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9208F265DA7
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:19:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9E9A6ADA9
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:19:45 +0000 (UTC)
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

snd-hdspm driver accesses enum item values (int) instead of boolean
values (long) wrongly for some ctl elements.  This patch fixes them.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8bc8016c173d..b047b1ba48fd 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2261,7 +2261,7 @@ static int snd_hdspm_put_system_sample_rate(struct snd_kcontrol *kcontrol,
 {
 	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	hdspm_set_dds_value(hdspm, ucontrol->value.enumerated.item[0]);
+	hdspm_set_dds_value(hdspm, ucontrol->value.integer.value[0]);
 	return 0;
 }
 
@@ -4449,7 +4449,7 @@ static int snd_hdspm_get_tco_word_term(struct snd_kcontrol *kcontrol,
 {
 	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.enumerated.item[0] = hdspm->tco->term;
+	ucontrol->value.integer.value[0] = hdspm->tco->term;
 
 	return 0;
 }
@@ -4460,8 +4460,8 @@ static int snd_hdspm_put_tco_word_term(struct snd_kcontrol *kcontrol,
 {
 	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	if (hdspm->tco->term != ucontrol->value.enumerated.item[0]) {
-		hdspm->tco->term = ucontrol->value.enumerated.item[0];
+	if (hdspm->tco->term != ucontrol->value.integer.value[0]) {
+		hdspm->tco->term = ucontrol->value.integer.value[0];
 
 		hdspm_tco_write(hdspm);
 
-- 
2.7.2
