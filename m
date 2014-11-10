From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ASoC: davinci-mcasp: fixes and
	over/underrun handling
Date: Mon, 10 Nov 2014 12:32:14 +0200
Message-ID: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D23FB2614A7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Some fixes for the mcasp code:
- rx formating fix
- constraint for number of channels and sample bits

handling of over/underrun:
When such event happens (in McASP vs DMA level) we force restart the stream in
order to get McASP and the DMA in sync again.

Regards,
Peter
---
Misael Lopez Cruz (2):
  ASoC: davinci-mcasp: Active slots depend on active serializers
  ASoC: davinci-mcasp: Add overrun/underrun event handling

Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Validate tdm_slots parameter at probe time
  ASoC: davinci-mcasp: Place constraint on number of channels
  ASoC: davinci-mcasp: Symmetric sample bits for IIS mode
  ASoC: davinci-mcasp: Fix rx format when more bclk is used on the bus

 .../bindings/sound/davinci-mcasp-audio.txt         |   2 +-
 sound/soc/davinci/davinci-mcasp.c                  | 212 +++++++++++++++++++--
 sound/soc/davinci/davinci-mcasp.h                  |  10 +
 3 files changed, 210 insertions(+), 14 deletions(-)

-- 
2.1.3
