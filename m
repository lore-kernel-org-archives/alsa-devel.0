From: Steve Soule <sts11dbxr@gmail.com>
Subject: [PATCH fixed bug 4032 1/1] Fixed bug 4032.
Date: Mon, 14 Dec 2009 11:41:55 -0700
Message-ID: <4B2686F3.8040001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2114848524282996699=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============2114848524282996699==
Content-Type: text/x-patch;
 name="0001-Fixed-bug-4032.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fixed-bug-4032.patch"

>From c3387a767f827f57a6b1f6b772d3d7a1b6b39942 Mon Sep 17 00:00:00 2001
From: Steve Soule <sts11dbxr@gmail.com>
Date: Mon, 14 Dec 2009 11:06:03 -0700
Subject: [PATCH fixed bug 4032 1/1] Fixed bug 4032.


Signed-off-by: Steve Soule <sts11dbxr@gmail.com>
---
 pci/ac97/ac97_codec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pci/ac97/ac97_codec.c b/pci/ac97/ac97_codec.c
index 20cb60a..c119206 100644
--- a/pci/ac97/ac97_codec.c
+++ b/pci/ac97/ac97_codec.c
@@ -2122,7 +2122,7 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		}
 		/* nothing should be in powerdown mode */
 		snd_ac97_write_cache(ac97, AC97_GENERAL_PURPOSE, 0);
-		end_time = jiffies + msecs_to_jiffies(120);
+		end_time = jiffies + msecs_to_jiffies(5000);
 		do {
 			if ((snd_ac97_read(ac97, AC97_POWERDOWN) & 0x0f) == 0x0f)
 				goto __ready_ok;
-- 
1.6.4.2


--===============2114848524282996699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2114848524282996699==--
