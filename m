From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: pcm3168a: Enable multiple digital
	port usage
Date: Thu, 20 Jun 2019 12:26:54 +0300
Message-ID: <20190620092656.14759-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7F64F896F4
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 11:26:23 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

On my board the pcm3168a's DIN1/2/3/4 and DOUT1/2/3 is connected to separate
McASP serializers.
I can run the audio in DIN1/DOUT1 mode (DSP_A, and switching between TDM and
normal mode), but I need to run the codec in multi DIN/DOUT mode which was not
possible as the driver is hardwired to DIN1/DOUT1 mode.

Use the set_tdm_slots we get information on the number of slots per FS so we can
use this to decide if we need to use multiple digital ports in parallel or to
use single ones in TDM mode.

The default mode remains DIN1/DOUT1.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: pcm3168a: Rename min_frame_size to slot_width
  ASoC: pcm3168a: Add support for multi DIN/DOUT with TDM slots
    parameter

 sound/soc/codecs/pcm3168a.c | 41 ++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
