From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958 channel
	status word
Date: Mon, 4 Jun 2012 14:07:16 -0500
Message-ID: <1338836836-7396-2-git-send-email-ricardo.neri@ti.com>
References: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 04B1B244C2
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 21:07:52 +0200 (CEST)
In-Reply-To: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>, alsa-devel@alsa-project.org, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

As the IEC-60958 channel status word is set by ANDing and ORing with
the appropriate definitions, the word bytes need to be initialized
to zero to avoid corruption due to previous hw_params calls.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index a08245d..24b40bd 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -108,6 +108,8 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * fill the IEC-60958 channel status word
 	 */
+	/* initialize the word bytes */
+	memset(iec->status, 0, sizeof(iec->status));
 
 	/* specify IEC-60958-3 (commercial use) */
 	iec->status[0] &= ~IEC958_AES0_PROFESSIONAL;
-- 
1.7.5.4
