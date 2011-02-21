From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] fix one memory leak in sound jack
Date: Mon, 21 Feb 2011 13:45:04 +0800
Message-ID: <1298267104-28697-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 82253103803
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 06:45:04 +0100 (CET)
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
Cc: Lu Guanqun <guanqun.lu@intel.com>, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, mranostay@embeddedalley.com, tj@kernel.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/core/jack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 4902ae5..53b53e9 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -141,6 +141,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 fail_input:
 	input_free_device(jack->input_dev);
+	kfree(jack->id);
 	kfree(jack);
 	return err;
 }
-- 
1.7.2.3
