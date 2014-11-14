From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 2/3] ALSA: ice1712: consider error value
Date: Fri, 14 Nov 2014 16:09:06 +0530
Message-ID: <1415961547-10330-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1415961547-10330-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415961547-10330-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

earlier we were ignoring the return value of snd_ak4114_create and
always returning 0.
now we are returning the actual status. revo_init is calling this
function, and revo_init is checking the return value.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/ice1712/revo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 1112ec1..2835196 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -498,7 +498,7 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
 	 * No reason to stop capture stream due to incorrect checks */
 	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
 
-	return 0; /* error ignored; it's no fatal error */
+	return err;
 }
 
 static int revo_init(struct snd_ice1712 *ice)
-- 
1.8.1.2
