From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: hda-intel: no soundcard with current linus' git
	tree
Date: Thu, 18 Oct 2007 03:53:08 +0200
Message-ID: <200710180353.08638.maximlevitsky@gmail.com>
References: <471538C2.80806@m3y3r.de> <471651C4.20907@m3y3r.de>
	<200710180351.50618.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 8769224521
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 03:53:37 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so362190ugf
	for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2007 18:53:37 -0700 (PDT)
In-Reply-To: <200710180351.50618.maximlevitsky@gmail.com>
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>From 0824b077b75c19253b45c5a455775c331acd54ee Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Thu, 18 Oct 2007 03:35:37 +0200
Subject: [PATCH] [HDA] [STAC] Since there is now a master volume control,
don't call the headphone output "Master", it isn't strictly correct anyway

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/patch_sigmatel.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 6dffa54..7f157a6 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1907,12 +1907,7 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
 			return err;
 	}
 	if (spec->multiout.hp_nid) {
-		const char *pfx;
-		if (old_num_dacs == spec->multiout.num_dacs)
-			pfx = "Master";
-		else
-			pfx = "Headphone";
-		err = create_controls(spec, pfx, spec->multiout.hp_nid, 3);
+		err = create_controls(spec, "Headphone", spec->multiout.hp_nid, 3);
 		if (err < 0)
 			return err;
 	}
-- 
1.5.3.4
