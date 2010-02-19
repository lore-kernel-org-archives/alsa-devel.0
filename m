From: Dan Carpenter <error27@gmail.com>
Subject: [patch] oxygen: clean up.  make precedence explicit
Date: Fri, 19 Feb 2010 09:58:56 +0300
Message-ID: <20100219065856.GA17130@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id AEDAD1037EA
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 07:59:36 +0100 (CET)
Received: by ewy5 with SMTP id 5so1507367ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 22:59:35 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This doesn't change anything, but I think it makes the code clearer.  
It silences a smatch warning:
sound/pci/oxygen/oxygen_mixer.c +91 dac_mute_put(7) warn: add some parenthesis here?

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Compile tested.

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index f375b8a..28590b9 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -88,7 +88,7 @@ static int dac_mute_put(struct snd_kcontrol *ctl,
 	int changed;
 
 	mutex_lock(&chip->mutex);
-	changed = !value->value.integer.value[0] != chip->dac_mute;
+	changed = (!value->value.integer.value[0]) != chip->dac_mute;
 	if (changed) {
 		chip->dac_mute = !value->value.integer.value[0];
 		chip->model.update_dac_mute(chip);
