From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] AM43xx-ePOS-EVM audio support with TLV320AIC31XX driver
Date: Tue, 4 Mar 2014 15:54:48 +0200
Message-ID: <cover.1393941102.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Since the RFC version of the patches [1] I have addressed Mark Browns
comments [2] as described in my mail here [3].

Besr regards,
Jyri

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073289.html

[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073703.html
    http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073704.html
    http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073705.html
    
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073807.html

Jyri Sarha (4):
  ASoC: tlv320aic31xx: Add basic codec driver implementation
  ASoC: davinci-evm: Add AM43xx-EPOS-EVM audio support
  ASoC: davinci: Add SND_AM43XX_SOC_EPOS_EVM build option
  ASoC: tlv320aic32x4: Sort Makefile in alphabetic order

 .../bindings/sound/davinci-evm-audio.txt           |    9 +-
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   58 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    9 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    6 +-
 sound/soc/codecs/tlv320aic31xx.c                   | 1345 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  258 ++++
 sound/soc/davinci/Kconfig                          |   12 +
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |   41 +
 10 files changed, 1738 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
