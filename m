From: Marius Graefe <alsa@mgraefe.de>
Subject: [PATCH - oxygen 1/1] Patch for the Xonar DG Patch by
	Roman Volkov
Date: Tue,  3 Dec 2013 16:46:01 +0100
Message-ID: <1386085561-20131-1-git-send-email-alsa@mgraefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Marius Graefe <alsa@mgraefe.de>, v1ron@mail.ru
List-Id: alsa-devel@alsa-project.org

I just tested Roman Volkovs oxygen patch for the xonar dg and it works like a charm, however I needed to change two lines in xonar_dg_mixer.c:

1) #include <linux/export.h> was missing which resulted in a warning when compiling.

2) I had to assign a .shortname in xonar_dg_model, otherwise my kernel (unmodified ubuntu 3.2.0-56-generic-pae) throws an oops, the backtrace led me to the missing string. Actually this is weird because the shortname is assigned in get_oxygen_model in oxygen.c, and alsamixer also shows that name later, but at some point in the kernel startup sequence it's NULL.

Volkovs Xonar DG 4-Patch series is required!

Signed-off-by: Marius Graefe <alsa@mgraefe.de>

diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index 39a0da7..102cfce 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -26,6 +26,7 @@
 
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
@@ -456,6 +457,7 @@ static int xonar_control_filter(struct snd_kcontrol_new *template)
 }
 
 struct oxygen_model model_xonar_dg = {
+	.shortname = "Xonar DG/DGX",
 	.longname = "C-Media Oxygen HD Audio",
 	.chip = "CMI8786",
 	.init = dg_init,
-- 
1.7.9.5
