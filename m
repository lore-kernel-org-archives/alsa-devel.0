From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] control: fulfill a description about
	element type with integer64
Date: Mon, 22 Feb 2016 01:54:19 +0900
Message-ID: <1456073659-15937-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id E37CD2606FF
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 17:54:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In UAPI of asound.h, there're 6 types of control element; boolean, integer,
enumerated, bytes, iec958 and integer64 (The none type seems to be added to
start the value at non-zero). Although, current description in alsa-lib
has a lack of integer64 type.

This commit fulfil the type.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/control.c b/src/control/control.c
index 70d168d..a44ae96 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -35,7 +35,7 @@ also interface notifying about control and structure changes.
 
 \section control_general_overview General overview
 
-The primitive controls can be integer, boolean, enumerators, bytes
+The primitive controls can be integer, inter64, boolean, enumerators, bytes
 and IEC958 structure.
 
 */
-- 
2.5.0
