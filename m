From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] sound: fix oss/msnd_pinnacle module param type
Date: Wed, 28 Mar 2012 18:26:13 -0700
Message-ID: <4F73BA35.7010009@xenotime.net>
References: <20120328171401.354ddb56727a26fe64b35ddf@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy8-pub.bluehost.com (oproxy8-pub.bluehost.com
	[69.89.22.20]) by alsa0.perex.cz (Postfix) with SMTP id ED9F024363
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 03:26:17 +0200 (CEST)
In-Reply-To: <20120328171401.354ddb56727a26fe64b35ddf@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix module parameter data type to eliminate build warning.

sound/oss/msnd_pinnacle.c:1727:1: warning: return from incompatible pointer type

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/oss/msnd_pinnacle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120328.orig/sound/oss/msnd_pinnacle.c
+++ linux-next-20120328/sound/oss/msnd_pinnacle.c
@@ -1631,7 +1631,7 @@ static int ide_irq __initdata = 0;
 static int joystick_io __initdata = 0;
 
 /* If we have the digital daugherboard... */
-static int digital __initdata = 0;
+static bool digital __initdata = false;
 #endif
 
 static int fifosize __initdata =	DEFFIFOSIZE;
