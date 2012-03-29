From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] sound: fix isa/opti9xx module param type
Date: Wed, 28 Mar 2012 18:26:17 -0700
Message-ID: <4F73BA39.5020509@xenotime.net>
References: <20120328171401.354ddb56727a26fe64b35ddf@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy3-pub.bluehost.com (oproxy3-pub.bluehost.com [69.89.21.8])
	by alsa0.perex.cz (Postfix) with SMTP id D232224363
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 03:26:19 +0200 (CEST)
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

Fix module parameter data type to eliminate build warnings.

sound/isa/opti9xx/opti92x-ad1848.c:87:1: warning: return from incompatible pointer type
sound/isa/opti9xx/opti92x-ad1848.c:87:1: warning: return from incompatible pointer type

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 sound/isa/opti9xx/opti92x-ad1848.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120328.orig/sound/isa/opti9xx/opti92x-ad1848.c
+++ linux-next-20120328/sound/isa/opti9xx/opti92x-ad1848.c
@@ -65,7 +65,7 @@ static int index = SNDRV_DEFAULT_IDX1;	/
 static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
 //static bool enable = SNDRV_DEFAULT_ENABLE1;	/* Enable this card */
 #ifdef CONFIG_PNP
-static int isapnp = 1;			/* Enable ISA PnP detection */
+static bool isapnp = true;			/* Enable ISA PnP detection */
 #endif
 static long port = SNDRV_DEFAULT_PORT1; 	/* 0x530,0xe80,0xf40,0x604 */
 static long mpu_port = SNDRV_DEFAULT_PORT1;	/* 0x300,0x310,0x320,0x330 */
