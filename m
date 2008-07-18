From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH2/2] hda: digital pc-beep support hd-audio
	codecs.
Date: Fri, 18 Jul 2008 09:25:15 -0400
Message-ID: <488099BB.1000204@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id D5564244DE
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 15:25:22 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added the respective file entry to call ../alsa-kernel/pci/hda_beep.c

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/hda_beep.c b/pci/hda/hda_beep.c
new file mode 100644
index 0000000..a8e16a5
--- /dev/null
+++ b/pci/hda/hda_beep.c
@@ -0,0 +1,3 @@
+#define __NO_VERSION__
+#include "adriver.h"
+#include "../../alsa-kernel/pci/hda/hda_beep.c"
