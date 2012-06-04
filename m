From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] ASoC: OMAP: HDMI: Initialize IEC-60958 channel
	status word
Date: Mon, 4 Jun 2012 14:07:15 -0500
Message-ID: <1338836836-7396-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 06BC2244C3
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 21:07:52 +0200 (CEST)
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

Hi Mark, Liam,

This patch is to fix an bug that I found in K3.5-rc1. As the IEC-60958 channel
status word is not initialized in hw_params, the params from previous
calls corrupt those of the current playback.

BR

Ricardo

Ricardo Neri (1):
  ASoC: OMAP: HDMI: Initialize IEC-60958 channel status word

 sound/soc/omap/omap-hdmi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.5.4
