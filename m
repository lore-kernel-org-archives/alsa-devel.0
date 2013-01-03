From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Switch "On" and "Off" for
	"Mute-LED Mode" kcontrol
Date: Thu,  3 Jan 2013 14:12:29 +0100
Message-ID: <1357218749-12103-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3E7261608
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 14:12:23 +0100 (CET)
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
Cc: tiwai@suse.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The vmaster hook sends 1 for enabled/unmuted and 0 for disabled/muted,
but "Mute-LED Mode" being "On" refers to the LED being on, not the
volume being on.
Therefore "On" and "Off" should be switched.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8353c77..b8fb0a5 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2531,7 +2531,7 @@ static int vmaster_mute_mode_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
 	static const char * const texts[] = {
-		"Off", "On", "Follow Master"
+		"On", "Off", "Follow Master"
 	};
 	unsigned int index;
 
-- 
1.7.9.5
