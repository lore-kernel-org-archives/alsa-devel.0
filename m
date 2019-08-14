From: vani.ganji@intel.com
Subject: [PATCH] ALSA: hda: Retry codec read on first time
	failure
Date: Wed, 14 Aug 2019 12:17:40 +0530
Message-ID: <20190814064740.9064-1-vani.ganji@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F41A2F80446
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 08:47:15 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: pierre-louis.bossart@linux.intel.com, vani.ganji@intel.com
List-Id: alsa-devel@alsa-project.org

From: Vani Ganji <vani.ganji@intel.com>

Sometimes HDMI audio fails while fast switching
between HDMI and Speaker due to codec Get Power state verb read failure.

Verb is codec driver to access codec HW. Since issue scenario involves
fast switching between HDMI and speaker, there might be chance to fail
read from HW and same happened in the error scenario.

Based on Display/Graphics architect suggestion, added a retry mechanism
for failure on first attempt.

Signed-off-by: Vani Ganji <vani.ganji@intel.com>
---
 sound/hda/hdac_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b26cc93e7e10..225bd1bfe156 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -984,10 +984,17 @@ static unsigned int codec_read(struct hdac_device *hdac, hda_nid_t nid,
 {
 	unsigned int cmd = snd_hdac_make_cmd(hdac, nid, verb, parm);
 	unsigned int res;
-
-	if (snd_hdac_exec_verb(hdac, cmd, flags, &res))
-		return -1;
-
+	unsigned int count;
+
+	/* Retry verb once more if it fails first time */
+	/* recommended to retry since it is HW related */
+	for (count = 0; count <= 1; count++) {
+		if (snd_hdac_exec_verb(hdac, cmd, flags, &res))
+			if (count == 1)
+				return -1;
+		} else
+			break;
+	}
 	return res;
 }
 
-- 
2.17.1
