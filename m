From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: soc-io,
	twl6040: Fix regression in linux-next
Date: Mon, 12 Mar 2018 16:24:21 +0200
Message-ID: <20180312142423.13177-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id DAD7B266E60
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 15:24:25 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

I just noticed in linux-next that after the codec -> component conversion the
twl6040 codec is not working (and most likely the twl4030 neither).

I have fixed it with the two patch in the series.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: twl6040: Add back missing write callback
  ASoC: soc-io: Fix snd_soc_component_update_bits_legacy

 sound/soc/codecs/twl6040.c | 1 +
 sound/soc/soc-io.c         | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
