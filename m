From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: Write outside array bounds
Date: Wed, 29 Jul 2009 12:25:11 +0200
Message-ID: <4A702387.8090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com
	[209.85.219.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E5B8103860
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 12:22:54 +0200 (CEST)
Received: by ewy28 with SMTP id 28so725699ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 03:22:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: wfg@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

e->sad[] is declared with size ELD_MAX_SAD (16), but the guard allows
the range 0-31

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with Parfait, http://research.sun.com/projects/parfait/

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index fcad5ec..ec04e58 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -539,7 +539,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 				sname++;
 				n = 10 * n + name[4] - '0';
 			}
-			if (n < 0 || n > 31) /* double the CEA limit */
+			if (n < 0 || n > ELD_MAX_SAD)
 				continue;
 			if (!strcmp(sname, "_coding_type"))
 				e->sad[n].format = val;
