From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [RFC][PATCH] Get rid of dead code in
	sound/pci/ac97/ac97_patch.c
Date: Tue, 31 Jul 2007 22:36:23 +0200
Message-ID: <46AF9D47.5090302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 48EF6103804
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 22:36:46 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so232611nfd
	for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2007 13:36:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

File /home/devel/linux-rdc/sound/pci/ac97/ac97_patch.c line 484
Unknown CONFIG option! CONFIG_TOUCHSCREEN_WM9705

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

--- linux-rdc-clean/sound/pci/ac97/ac97_patch.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-rdc/sound/pci/ac97/ac97_patch.c	2007-07-31 17:26:32.000000000 +0200
@@ -481,10 +481,7 @@ static int patch_wolfson05(struct snd_ac
 {
 	/* WM9705, WM9710 */
 	ac97->build_ops = &patch_wolfson_wm9705_ops;
-#ifdef CONFIG_TOUCHSCREEN_WM9705
-	/* WM9705 touchscreen uses AUX and VIDEO for touch */
-	ac97->flags |= AC97_HAS_NO_VIDEO | AC97_HAS_NO_AUX;
-#endif
+
 	return 0;
 }
