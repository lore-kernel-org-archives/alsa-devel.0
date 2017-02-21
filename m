From: simon.ho.cnxt@gmail.com
Subject: [alsa_devel] [PATCH v3 0/2] ASoC: add driver support
	for Conexant CX2092X DSP
Date: Tue, 21 Feb 2017 21:58:23 +0800
Message-ID: <cover.1487684248.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id F07B12666EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 14:58:29 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id x35so7030250qtc.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 05:58:29 -0800 (PST)
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

Hi Mark, Takashi

I corrected the driver based on your input as below.

  - GPIO specifier names have to be pluralised. 
  - Using gpiod_ instead of gpio APIs.
  - Using cansleep () gpio version.
  - Using cansleep () gpio version.
  - Moving the driver information to patch description.

Thanks,

Simoon

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
