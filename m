From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: twl6040: Remove PLL restrictions
Date: Thu, 13 Oct 2011 15:05:40 +0300
Message-ID: <1318507544-26856-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 912E510385F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 14:05:57 +0200 (CEST)
Received: by dyf17 with SMTP id 17so68907dyf.18
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 05:05:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

twl6040 has no restrictions on the selected PLL, and sysclk.
All input, and output paths can be used with any PLL configuration.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: twl6040: Remove Capture restriction for 17.64MHz sysclk
  ASoC: twl6040: Remove PLL usage restrictions
  ASoC: twl6040: Change event ordering for Earphone driver
  ASoC: twl6040: Rename the Earphone Driver event handler

 sound/soc/codecs/twl6040.c |   53 ++++++++++----------------------------------
 1 files changed, 12 insertions(+), 41 deletions(-)

-- 
1.7.7
