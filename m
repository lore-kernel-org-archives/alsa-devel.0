From: simon.ho.cnxt@gmail.com
Subject: [PATCH 0/2] ASoC: Add driver for CX2072X CODEC
Date: Sat, 17 Dec 2016 15:52:31 +0800
Message-ID: <cover.1481903061.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 185C7266569
 for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2016 08:52:40 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id c4so5423225pfb.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 23:52:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Simon Ho <simon.ho@conexant.com>
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Re-send the patch because my previous email was sent by a non-member
email account and are being held. So please disregard my previous email
if you saw it. Sorry if I caused any trouble. 

This patch adds support for Conexant CX2072X codec driver.

The CX2072X is a ultra low power stereo audio codec supports I2S/TDM
host interface with EQ, DRC features in playback mode.

Featues of CX2072X codec:

 * Two 24 bits DACs and DACs.
 * Stereo Headphone AMP.
 * 2.8W per channel class-D output.
 * Integrated seven bands per channel EQ and DRC.
 * Fully integrated headset support with detect/switch.
 * Stereo digital microphone for array applications.
 * S/PDIF output.
 * Bi-directional GPIOs.
 * Support analog and digital PC Beeep.
 * One headset button support.
 * Supports a wide variety of host interfaces.
   -wide variety of I2S and similar bit-stream formats
    with word lengths of up to 24 bits.
   -TDM stream supports up to 4 channels.
 * AEC loopback support.

Simon Ho (2):
  ASoC: cx2072x: Add DT bingings documentation for CX2072X CODEC
  ASoC: cx2072x Add driver for CX2072X CODEC

 .../devicetree/bindings/sound/cx2072x.txt          |   36 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cx2072x.c                         | 2080 ++++++++++++++++++++
 sound/soc/codecs/cx2072x.h                         |  322 +++
 5 files changed, 2445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cx2072x.txt
 create mode 100644 sound/soc/codecs/cx2072x.c
 create mode 100644 sound/soc/codecs/cx2072x.h

-- 
2.7.4
