Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CC19F801A4
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 08:42:49 +0200 (CEST)
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 26 Jul 2019 09:42:42 +0300
Message-ID: <20190726064244.3762-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 0/2] ASoC: ti: davinci-mcasp: sample format
	constraint fixes
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, tiwai@suse.com, jsarha@ti.com
List-ID: <alsa-devel@alsa-project.org>

Hi,

The two patch fixes two issues on how the driver have placed constraints on the
format size.
1. When the first stream starts and the TDM slot_width is configured we can
   allow formats which require less or equal number of bits on the bus.
2. For the second stream we must allow only formats which uses exact number of
   bits on the bus.

These issues are visible around the S24_3LE, S24_LE and S32_LE formats.
  
Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: ti: davinci-mcasp: Correct slot_width posed constraint
  ASoC: ti: davinci-mcasp: Support for correct symmetric sample bits

 sound/soc/ti/davinci-mcasp.c | 91 +++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 12 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
