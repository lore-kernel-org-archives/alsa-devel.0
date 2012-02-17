From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: core: Constify the name in new kcontrols
Date: Thu, 16 Feb 2012 17:09:09 -0800
Message-ID: <1329440949-20353-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09F29243A3
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:09:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We never modify it and this lets us use a const string as the name without
warnings.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

I've got some ASoC patches which need this to avoid warnings, if you're
OK with it can I apply it via there please?

 include/sound/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index b2796e8..57815f6 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -40,7 +40,7 @@ struct snd_kcontrol_new {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
-	unsigned char *name;		/* ASCII name of item */
+	const unsigned char *name;	/* ASCII name of item */
 	unsigned int index;		/* index of item */
 	unsigned int access;		/* access rights */
 	unsigned int count;		/* count of same elements */
-- 
1.7.9.rc1
