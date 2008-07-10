From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] alsa: correct kcalloc usage
Date: Thu, 10 Jul 2008 16:28:48 -0500 (CDT)
Message-ID: <for-27-patch8-3@bga.com>
References: <for-27-patch8-1@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	by alsa0.perex.cz (Postfix) with ESMTP id EBE8C1037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 23:28:53 +0200 (CEST)
In-Reply-To: <for-27-patch8-1@bga.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.org
List-Id: alsa-devel@alsa-project.org

kcalloc is supposed to be called with the count as its first argument and
the element size as the second.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Both arguments are size_t so does not affect correctness.  This callsite is
during module_init and therefore not performance critical.  Another patch
will optimize the case when the count is variable but the size is fixed.

alsa-devel on bcc due to  (subscribers-only)


diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 7efb838..06d13e7 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1302,8 +1302,8 @@ snd_nm256_mixer(struct nm256 *chip)
 		.read = snd_nm256_ac97_read,
 	};
 
-	chip->ac97_regs = kcalloc(sizeof(short),
-				  ARRAY_SIZE(nm256_ac97_init_val), GFP_KERNEL);
+	chip->ac97_regs = kcalloc(ARRAY_SIZE(nm256_ac97_init_val),
+				  sizeof(short), GFP_KERNEL);
 	if (! chip->ac97_regs)
 		return -ENOMEM;
