From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Fix calling cs_automic twice for
	Cirrus codecs.
Date: Tue, 31 Jan 2012 13:04:41 -0800
Message-ID: <1328043881-14910-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f201.google.com (mail-qy0-f201.google.com
	[209.85.216.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AB6C243CF
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 22:04:49 +0100 (CET)
Received: by qcse1 with SMTP id e1so65452qcs.2
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 13:04:49 -0800 (PST)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

If cs_automic is called twice (like it is during init) while the mic
is present, it will over-write the last_input with the new one,
causing it to switch back to the automic input when the mic is
unplugged. This leaves the driver in a state (cur_input, last_input,
and automix_idx the same) where the internal mic can not be selected
until it is rebooted without the mic attached.

Check that the mic hasn't already been switched to before setting
last_input.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_cirrus.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 0e99357..bc5a993 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -988,8 +988,10 @@ static void cs_automic(struct hda_codec *codec)
 			change_cur_input(codec, !spec->automic_idx, 0);
 	} else {
 		if (present) {
-			spec->last_input = spec->cur_input;
-			spec->cur_input = spec->automic_idx;
+			if (spec->cur_input != spec->automic_idx) {
+				spec->last_input = spec->cur_input;
+				spec->cur_input = spec->automic_idx;
+			}
 		} else  {
 			spec->cur_input = spec->last_input;
 		}
-- 
1.7.9.rc0
