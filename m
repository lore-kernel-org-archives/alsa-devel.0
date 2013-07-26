From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/3 V2] ALSA: hda - jack poll once if
	jackpoll_interval==0
Date: Thu, 25 Jul 2013 23:34:45 -0400
Message-ID: <1374809686-3886-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1374809686-3886-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FC2C2610AF
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 04:59:47 +0200 (CEST)
In-Reply-To: <1374809686-3886-1-git-send-email-xingchao.wang@linux.intel.com>
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

With jackpoll_interval != 0, it's used to poll jack event periodically
in a delayed work. if it's 0, give the caller chance to probe jack status
but will not restart the delayed work.

In the next patch which enable WAKEEN feature, HDA controller was able to wake
up system when it's in D3, it's useful to detect Jack hotplug event and notify
userspace. By default the jackpoll_interval=0, this patch let jack poll once
without starting the delayed work.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8a005f0..fdbb09a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1216,11 +1216,13 @@ static void hda_jackpoll_work(struct work_struct *work)
 {
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, jackpoll_work.work);
-	if (!codec->jackpoll_interval)
-		return;
 
 	snd_hda_jack_set_dirty_all(codec);
 	snd_hda_jack_poll_all(codec);
+
+	if (!codec->jackpoll_interval)
+		return;
+
 	queue_delayed_work(codec->bus->workq, &codec->jackpoll_work,
 			   codec->jackpoll_interval);
 }
-- 
1.8.3.2
