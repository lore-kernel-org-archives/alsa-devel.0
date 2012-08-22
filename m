From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Do not set GPIOs for speakers on
	IDT if there are no speakers
Date: Wed, 22 Aug 2012 16:10:43 +0200
Message-ID: <1345644643-9998-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 034872660E5
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 16:10:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, 1040077@bugs.launchpad.net
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This fixes an issue with a machine where there were no speakers,
but GPIO0 had to be data=1 for the headphone to be functioning.

I'm not sure if we need a more advanced patch to solve all possible cases,
but if so, this patch would still provide a minor optimisation.

BugLink: https://bugs.launchpad.net/bugs/1040077
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    3 +++
 1 file changed, 3 insertions(+)

The alsa-info for this machine can not be released yet, sorry.

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index ea5775a..3edd73c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4543,6 +4543,9 @@ static void stac92xx_line_out_detect(struct hda_codec *codec,
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
+	if (cfg->speaker_outs == 0)
+		return;
+
 	for (i = 0; i < cfg->line_outs; i++) {
 		if (presence)
 			break;
-- 
1.7.9.5
