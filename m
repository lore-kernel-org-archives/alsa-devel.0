From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix incorrect clearance of
	thinkpad_acpi hooks
Date: Tue,  6 Nov 2018 13:35:25 +0100
Message-ID: <20181106123525.32383-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DDA32678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 13:35:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DCA3CB619
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 12:35:26 +0000 (UTC)
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

Since the commit c647f806b8c2 ("ALSA: hda - Allow multiple ADCs for
mic mute LED controls") we allow enabling the mic mute LED with
multiple ADCs.  The commit changed the function return value to be
zero or a negative error, while this change was overlooked in the
thinkpad_acpi helper code where it still expects a positive return
value for success.  This eventually leads to a NULL dereference on a
system that has only a mic mute LED.

This patch corrects the return value check in the corresponding code
as well.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201621
Fixes: c647f806b8c2 ("ALSA: hda - Allow multiple ADCs for mic mute LED controls")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/thinkpad_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 97f49b751e6e..568575b72f2f 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -58,8 +58,8 @@ static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
 			removefunc = false;
 		}
 		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0 &&
-		    snd_hda_gen_add_micmute_led(codec,
-						update_tpacpi_micmute) > 0)
+		    !snd_hda_gen_add_micmute_led(codec,
+						 update_tpacpi_micmute))
 			removefunc = false;
 	}
 
-- 
2.19.1
