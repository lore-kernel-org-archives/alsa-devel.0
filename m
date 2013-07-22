From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/3] ALSA: hda - jack poll once if
	jackpoll_interval==0
Date: Mon, 22 Jul 2013 03:19:16 -0400
Message-ID: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BB224261741
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 08:43:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, david.henningsson@canonical.com
Cc: Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

jackpoll_interval used to poll jack event periodically, if it's 0,
give the caller one chance to probe jack status.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8a005f0..74c11bc 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1216,11 +1216,12 @@ static void hda_jackpoll_work(struct work_struct *work)
 {
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, jackpoll_work.work);
-	if (!codec->jackpoll_interval)
-		return;
 
 	snd_hda_jack_set_dirty_all(codec);
 	snd_hda_jack_poll_all(codec);
+	if (!codec->jackpoll_interval)
+		return;
+
 	queue_delayed_work(codec->bus->workq, &codec->jackpoll_work,
 			   codec->jackpoll_interval);
 }
-- 
1.8.3.2
