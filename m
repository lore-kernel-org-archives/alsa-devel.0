From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: pcm3168a: DAC/ADC independence and
	right_j fix
Date: Mon, 12 Aug 2019 12:52:24 +0300
Message-ID: <20190812095226.18870-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B785FF801EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 11:52:19 +0200 (CEST)
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

The first patch makes sure that the DAC and ADC side of the codec can be used
and configured independently from each other.

The second patch allows the reconfiguration of tdm_slots and slot_width. It is
needed in case the codec is configured as slave and right_j whisch is the only
mode when it can support 16 and 24 bit audio, but 16 bit requires 16 slot_width
while 24 bit can use 48 or 32 slot_width. The codec driver must allow runtime
reconfiguration of the tdm_slots and slot_width for this purpose.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: pcm3168a: Retain the independence of DAC and ADC side of the
    codec
  ASoC: pcm3168a: Allow reconfiguration of tdm_slots and slot_width

 sound/soc/codecs/pcm3168a.c | 129 ++++++++++++++----------------------
 1 file changed, 50 insertions(+), 79 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
