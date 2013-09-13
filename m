From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ALSA: hda/ca0132: Staticize
	codec_send_command
Date: Fri, 13 Sep 2013 15:14:22 +0530
Message-ID: <1379065462-1720-2-git-send-email-sachin.kamat@linaro.org>
References: <1379065462-1720-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4882D2608D0
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:02:35 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id kx10so2324603pab.41
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:02:34 -0700 (PDT)
In-Reply-To: <1379065462-1720-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

'codec_send_command' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6e9876f..54d1479 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -759,7 +759,7 @@ struct ca0132_spec {
 /*
  * CA0132 codec access
  */
-unsigned int codec_send_command(struct hda_codec *codec, hda_nid_t nid,
+static unsigned int codec_send_command(struct hda_codec *codec, hda_nid_t nid,
 		unsigned int verb, unsigned int parm, unsigned int *res)
 {
 	unsigned int response;
-- 
1.7.9.5
