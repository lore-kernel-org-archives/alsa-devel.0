From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] ASoC: hdac_hdmi: convert num_nodes to int
Date: Thu, 26 Nov 2015 13:38:19 +0530
Message-ID: <1448525299-7011-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 31AED264F23
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 09:08:30 +0100 (CET)
Received: by ioir85 with SMTP id r85so78558817ioi.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 00:08:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

All uses of num_nodes are considering it as a signed integer and that is
very much clear when we try to save the error value in it and later try
to compare it with less than 0.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 include/sound/hdaudio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index e2b712c..c5fad14 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -71,7 +71,7 @@ struct hdac_device {
 			 unsigned int flags, unsigned int *res);
 
 	/* widgets */
-	unsigned int num_nodes;
+	int num_nodes;
 	hda_nid_t start_nid, end_nid;
 
 	/* misc flags */
-- 
1.9.1
