From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 31/38] ALSA: hda/realtek - Add model=fixup not
	to apply fix-ups
Date: Fri, 24 Feb 2012 17:36:24 +0100
Message-ID: <1330101391-8788-32-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id B09F7104325
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B0CAE92EF4
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

If anyone wants to debug the driver and avoid the existing fix-ups,
pass model=nofixup option.  Then the driver will skip to pick up the
fixup list.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ac1e38..3c6f5b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1556,6 +1556,13 @@ static void alc_pick_fixup(struct hda_codec *codec,
 	int id = -1;
 	const char *name = NULL;
 
+	/* when model=nofixup is given, don't pick up any fixups */
+	if (codec->modelname && !strcmp(codec->modelname, "nofixup")) {
+		spec->fixup_list = NULL;
+		spec->fixup_id = -1;
+		return;
+	}
+
 	if (codec->modelname && models) {
 		while (models->name) {
 			if (!strcmp(codec->modelname, models->name)) {
-- 
1.7.9
