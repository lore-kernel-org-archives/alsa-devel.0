From: apatard@mandriva.com
Subject: [patch 3/6] soc-dapm.h: add SND_SOC_DAPM_PRE_POST_PMD
	event
Date: Thu, 27 May 2010 14:57:40 +0200
Message-ID: <20100527130338.487101110@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id BDEC9103A59
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:03:44 +0200 (CEST)
Content-Disposition: inline; filename=add_dapm_pre_port_pmd.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Some systems codecs need to configure some registers before and after powering down
some of their part. As a convenience, I'm adding a macro for that.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/include/sound/soc-dapm.h
===================================================================
--- sound-2.6.orig/include/sound/soc-dapm.h	2010-05-27 14:09:32.932174265 +0200
+++ sound-2.6/include/sound/soc-dapm.h	2010-05-27 14:09:47.536194064 +0200
@@ -273,6 +273,8 @@
 #define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
 #define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
 #define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
+#define SND_SOC_DAPM_PRE_POST_PMD \
+				(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
 
 /* convenience event type detection */
 #define SND_SOC_DAPM_EVENT_ON(e)	\
