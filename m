From: Ricardo Neri <rneri@dextratech.com>
Subject: [RESEND PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958
	channel status word
Date: Thu, 10 Jan 2013 18:32:13 -0600
Message-ID: <1357864333-18742-1-git-send-email-rneri@dextratech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dextratech.com (spamfilter.dextratech.com [187.141.251.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 68E0B2616FC
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 01:32:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: Ricardo Neri <rneri@dextratech.com>, alsa-devel@alsa-project.org, dzuniga@dextratech.com
List-Id: alsa-devel@alsa-project.org

As the IEC-60958 channel status word is set by ANDing and ORing with
the appropriate definitions, the word bytes need to be initialized
to zero to avoid misconfiguration due to previous hw_params calls.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 sound/soc/omap/omap-hdmi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index f59c69f..75ad378 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -110,6 +110,8 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * fill the IEC-60958 channel status word
 	 */
+	/* initialize the word bytes */
+	memset(iec->status, 0, sizeof(iec->status));

 	/* specify IEC-60958-3 (commercial use) */
 	iec->status[0] &= ~IEC958_AES0_PROFESSIONAL;
--
1.7.10.4
