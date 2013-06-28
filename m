From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix the max length of control
	name in generic parser
Date: Fri, 28 Jun 2013 12:23:17 +0200
Message-ID: <1372414998-7618-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE8C32656A0
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 12:22:27 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AFE00A5359
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 12:22:27 +0200 (CEST)
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

add_control_with_pfx() in hda_generic.c assumes a shorter name string
for the control element, and this resulted in the truncation of the
long but valid string like "Headphone Surround Switch" in the middle.

This patch aligns the max size to the actual limit of snd_ctl_elem_id,
44.

Cc: <stable@vger.kernel.org> [v3.9+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 1485d87..6460fc5 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -854,7 +854,7 @@ static int add_control_with_pfx(struct hda_gen_spec *spec, int type,
 				const char *pfx, const char *dir,
 				const char *sfx, int cidx, unsigned long val)
 {
-	char name[32];
+	char name[44];
 	snprintf(name, sizeof(name), "%s %s %s", pfx, dir, sfx);
 	if (!add_control(spec, type, name, cidx, val))
 		return -ENOMEM;
-- 
1.8.3.1
