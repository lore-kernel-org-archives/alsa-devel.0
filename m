From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: hda - Remove superfluous header
	inclusions
Date: Tue, 16 May 2017 09:23:50 +0200
Message-ID: <20170516072350.25070-7-tiwai@suse.de>
References: <20170516072350.25070-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E58D12674CF
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:23:52 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9D8F1ABCA
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:23:52 +0000 (UTC)
In-Reply-To: <20170516072350.25070-1-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0593d674de95..821aad374a06 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -19,13 +19,11 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
-#include <linux/async.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <sound/core.h>
-- 
2.12.2
