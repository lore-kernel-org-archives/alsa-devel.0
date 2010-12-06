From: Jeffrin Jose <ahiliation@yahoo.co.in>
Subject: sound: Fixed line limit issue in sound/ac97_bus.c
Date: Mon, 6 Dec 2010 20:37:24 +0530
Message-ID: <20101206150724.GA2752@debian.Jeff>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ahiliation@yahoo.co.in
List-Id: alsa-devel@alsa-project.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello.
a small patch for a format issue is attached with this
mail.
-- 
software engineer.
department of computer science
rajagiri school of engineering and technology.

--fdj2RfSjLxBAspz7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-sound-Fixed-line-limit-issue-in-sound-ac97_bus.c.patch"

>From a2c2867876c246420a199a0fb4c36ad2965a42cc Mon Sep 17 00:00:00 2001
From: Jeffrin Jose <ahiliation@yahoo.co.in>
Date: Mon, 6 Dec 2010 19:27:53 +0530
Subject: [PATCH] sound: Fixed line limit issue in sound/ac97_bus.c
 This is a patch to the sound/ac97_bus.c file that fixes up a 80 character
 line limit issue found by the checkpatch.pl tool.
 Signed-off-by: Jeffrin Jose <ahiliation@yahoo.co.in>

---
 sound/ac97_bus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index a351dd0..c93251a 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -19,9 +19,9 @@
 
 /*
  * Let drivers decide whether they want to support given codec from their
- * probe method.  Drivers have direct access to the struct snd_ac97 structure and may
- * decide based on the id field amongst other things.
- */
+ * probe method. Drivers have direct access to the struct snd_ac97
+ * structure and may  decide based on the id field amongst other things.
+*/
 static int ac97_bus_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
-- 
1.7.1


--fdj2RfSjLxBAspz7--
