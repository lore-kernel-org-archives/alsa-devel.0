From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3] ALSA: ice1712: consider error value
Date: Fri, 14 Nov 2014 16:56:49 +0530
Message-ID: <1415964409-12580-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
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

change in v3: spec->ak4114 is now dereferenced if we dont get an
error value from snd_ak4114_create.

 sound/pci/ice1712/revo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 1112ec1..24a7c6a 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -496,9 +496,10 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
 				 ice, &spec->ak4114);
 	/* AK4114 in Revo cannot detect external rate correctly.
 	 * No reason to stop capture stream due to incorrect checks */
-	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
+	if (err == 0)
+		spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
 
-	return 0; /* error ignored; it's no fatal error */
+	return err;
 }
 
 static int revo_init(struct snd_ice1712 *ice)
-- 
1.8.1.2
