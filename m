From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: Read buffer overflow
Date: Sun, 02 Aug 2009 13:30:45 +0200
Message-ID: <4A7578E5.4070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CB1D2434A
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Aug 2009 13:27:36 +0200 (CEST)
Received: by ewy8 with SMTP id 8so1442485ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 02 Aug 2009 04:27:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Check whether index is within bounds before testing the element.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c8b273..45e0ee0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -559,7 +559,7 @@ static int alc_pin_mode_get(struct snd_kcontrol *kcontrol,
 
 	/* Find enumerated value for current pinctl setting */
 	i = alc_pin_mode_min(dir);
-	while (alc_pin_mode_values[i] != pinctl && i <= alc_pin_mode_max(dir))
+	while (i <= alc_pin_mode_max(dir) && alc_pin_mode_values[i] != pinctl)
 		i++;
 	*valp = i <= alc_pin_mode_max(dir) ? i: alc_pin_mode_min(dir);
 	return 0;
