From: simon.ho.cnxt@gmail.com
Subject: [PATCH v2 0/2] ASoC: add driver support for Conexant
	CX2092X DSP
Date: Tue, 21 Feb 2017 09:01:50 +0800
Message-ID: <cover.1487595577.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id DD2C02666F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 02:01:56 +0100 (CET)
Received: by mail-qk0-f194.google.com with SMTP id p22so17597363qka.3
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 17:01:56 -0800 (PST)
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
Cc: Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

This patch adds support for Conexant CX20921/CX20924 I2S AUDIO DSP

The CX2092X devices are designed for virtual assisant application need to
be always open, listening for users to summon it. There is no any power
saving mode support on this device. The processed voice data will be sent
to automatic speech recognition (ASR) application for further processing.

Simon Ho (2):
  doc: cx2092x: Add DT bingings doc for CX2092X DSP
  ASoC: Add driver support fro Conexant CX2092X DSP

 .../devicetree/bindings/sound/cnxt,cx2092x.txt     |  29 ++
 sound/soc/codecs/Kconfig                           |  17 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/cx2092x-i2c.c                     |  54 +++
 sound/soc/codecs/cx2092x-spi.c                     |  57 +++
 sound/soc/codecs/cx2092x.c                         | 411 +++++++++++++++++++++
 sound/soc/codecs/cx2092x.h                         |  26 ++
 7 files changed, 600 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
 create mode 100644 sound/soc/codecs/cx2092x-i2c.c
 create mode 100644 sound/soc/codecs/cx2092x-spi.c
 create mode 100644 sound/soc/codecs/cx2092x.c
 create mode 100644 sound/soc/codecs/cx2092x.h

-- 
2.7.4
