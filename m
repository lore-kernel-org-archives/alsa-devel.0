From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Remove GPIO_MASK
Date: Mon,  3 Jul 2017 17:26:50 +0800
Message-ID: <20170703092650.30284-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B923B266884
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 11:26:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

GPIO_MASK was introduced in commit "df694daa3c01 [ALSA] hda-codec - Add
the support of ALC262,ALC883,ALC885,ALC861" but it's not being used. So
we can simply remove it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c79491a1cd47..425a4abd8ad0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -41,9 +41,6 @@
 /* keep halting ALC5505 DSP, for power saving */
 #define HALT_REALTEK_ALC5505
 
-/* for GPIO Poll */
-#define GPIO_MASK	0x03
-
 /* extra amp-initialization sequence types */
 enum {
 	ALC_INIT_NONE,
-- 
2.13.2
