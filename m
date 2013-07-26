From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/3] ALSA: hda - Clearing jackpoll_interval
	avoid pending work
Date: Thu, 25 Jul 2013 23:34:44 -0400
Message-ID: <1374809686-3886-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id AF42D2610AD
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 04:59:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, david.henningsson@canonical.com, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Clearing jackpoll_interval before calling cancel_delayed_work_sync(),
otherwise the work will be triggered again and cause impact in
hda_jackpoll_work(). The next patch will poll jack once even with
jackpoll_interval=0.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/patch_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index e2481ba..0bc20ef 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -207,9 +207,9 @@ static void vt1708_stop_hp_work(struct hda_codec *codec)
 		return;
 	if (spec->hp_work_active) {
 		snd_hda_codec_write(codec, 0x1, 0, 0xf81, 1);
+		codec->jackpoll_interval = 0;
 		cancel_delayed_work_sync(&codec->jackpoll_work);
 		spec->hp_work_active = false;
-		codec->jackpoll_interval = 0;
 	}
 }
 
-- 
1.8.3.2
