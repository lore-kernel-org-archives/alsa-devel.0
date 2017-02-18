From: simon.ho.cnxt@gmail.com
Subject: [PATCH 0/2] ASoC: add driver support for Conexant
	CX2092X DSP
Date: Sat, 18 Feb 2017 22:26:29 +0800
Message-ID: <1487427991-18174-1-git-send-email-simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5D58266838
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 15:26:37 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id 68so6266570pfx.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 06:26:37 -0800 (PST)
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

Simon Ho (2):
  ASoC: cx2092x: Add DT bingings doc for CX2092X DSP
  ASoC: Add driver for CX2092X I2S Audio DSP

 .../devicetree/bindings/sound/cx2092x.txt          |  30 ++
 sound/soc/codecs/Kconfig                           |  17 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/cx2092x-i2c.c                     |  54 +++
 sound/soc/codecs/cx2092x-spi.c                     |  57 +++
 sound/soc/codecs/cx2092x.c                         | 419 +++++++++++++++++++++
 sound/soc/codecs/cx2092x.h                         |  26 ++
 7 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cx2092x.txt
 create mode 100644 sound/soc/codecs/cx2092x-i2c.c
 create mode 100644 sound/soc/codecs/cx2092x-spi.c
 create mode 100644 sound/soc/codecs/cx2092x.c
 create mode 100644 sound/soc/codecs/cx2092x.h

-- 
2.7.4
