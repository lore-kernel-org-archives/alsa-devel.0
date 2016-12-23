From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: tlv320aic3x: Pop noise reductions
Date: Fri, 23 Dec 2016 11:21:09 +0200
Message-ID: <20161223092112.7992-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id BCF50266949
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 10:21:05 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

When we don't have any active component between the output of the codec and the
speaker/jack the codec emmits pop noise due to several factors:
- RESET register is toggled by regcache_sync (patch 1)
- After regcache_sync we need to wait a bit to allow the codec to settle down:
  the codec will be soft reseted when it is powered down, so when we power it on
  and run regcache_sync, we need to wait for the flushed settings to be valid.
  (patch 2)
- The HP ouptut power-down mode can be changed to be driven weakly to VCM, this
  can reduce the pop noise as well, with slight increase in powere consumption.

These factors were not taken care as in n810 and n900 we have external active
amplifiers and they will remove any artifacts coming from the codec, but on
boards w/o active external components they can reach the output.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: tlv320aic3x: Mark the RESET register as volatile
  ASoC: tlv320aic3x: Add delay after power on and register sync
  ASoC: tlv320aic3x: Add controls for selecting HP power down modes

 sound/soc/codecs/tlv320aic3x.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.11.0
