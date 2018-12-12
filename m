From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emux_hwdep: Fix potential Spectre v1 vulnerabilities
Date: Wed, 12 Dec 2018 11:20:49 -0600
Message-ID: <20181212172049.GA22723@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

info.mode and info.port are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

These issues were detected with the help of Smatch:

sound/synth/emux/emux_hwdep.c:72 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs[i]->ctrls' [w] (local cap)
sound/synth/emux/emux_hwdep.c:75 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs' [w] (local cap)
sound/synth/emux/emux_hwdep.c:75 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs[info.port]->ctrls' [w] (local cap)

Fix this by sanitizing both info.mode and info.port before using them
to index emu->portptrs[i]->ctrls, emu->portptrs[info.port]->ctrls and
emu->portptrs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/synth/emux/emux_hwdep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index e557946718a9..a0d5cd99572f 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -24,6 +24,7 @@
 #include <linux/uaccess.h>
 #include "emux_voice.h"
 
+#include <linux/nospec.h>
 
 #define TMP_CLIENT_ID	0x1001
 
@@ -66,13 +67,16 @@ snd_emux_hwdep_misc_mode(struct snd_emux *emu, void __user *arg)
 		return -EFAULT;
 	if (info.mode < 0 || info.mode >= EMUX_MD_END)
 		return -EINVAL;
+	info.mode = array_index_nospec(info.mode, EMUX_MD_END);
 
 	if (info.port < 0) {
 		for (i = 0; i < emu->num_ports; i++)
 			emu->portptrs[i]->ctrls[info.mode] = info.value;
 	} else {
-		if (info.port < emu->num_ports)
+		if (info.port < emu->num_ports) {
+			info.port = array_index_nospec(info.port, emu->num_ports);
 			emu->portptrs[info.port]->ctrls[info.mode] = info.value;
+		}
 	}
 	return 0;
 }
-- 
2.17.1
