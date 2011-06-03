From: Joe Perches <joe@perches.com>
Subject: [Trivial PATCH 4/5] ALSA: asihpi: Use angle brackets for system includes
Date: Fri,  3 Jun 2011 02:28:49 -0700
Message-ID: <ffe619f08dd89fbeefb13bcba0a6e98f9662c8f8.1307092589.git.joe@perches.com>
References: <cover.1307092588.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1307092588.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use the normal include style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/asihpi/hpidspcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index fb311d8..5c6ea11 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -60,7 +60,7 @@ struct code_header {
 	    HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
 
 /***********************************************************************/
-#include "linux/pci.h"
+#include <linux/pci.h>
 /*-------------------------------------------------------------------*/
 short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
 	u32 *pos_error_code)
-- 
1.7.5.rc3.dirty
