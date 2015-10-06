From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/18] ALSA: hda: move hda_hwdep to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:42 +0100
Message-ID: <1444144075-28963-6-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F64C26574A
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:43 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move hda_hwdep to use newly moved snd_hdac_read_codec() API

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_hwdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 57df06e76968..359d4e54d672 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -37,8 +37,8 @@ static int verb_write_ioctl(struct hda_codec *codec,
 
 	if (get_user(verb, &arg->verb))
 		return -EFAULT;
-	res = snd_hda_codec_read(codec, verb >> 24, 0,
-				 (verb >> 8) & 0xffff, verb & 0xff);
+	res = snd_hdac_codec_read(&codec->core, verb >> 24, 0,
+				  (verb >> 8) & 0xffff, verb & 0xff);
 	if (put_user(res, &arg->res))
 		return -EFAULT;
 	return 0;
-- 
2.4.3
