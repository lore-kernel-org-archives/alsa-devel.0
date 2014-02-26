From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 0/2] ASoC: ARM Cirrus Logic CLPS711X DAI driver
Date: Wed, 26 Feb 2014 20:05:40 +0400
Message-ID: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp25.mail.ru (smtp25.mail.ru [94.100.176.178])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0DE265D97
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 17:11:04 +0100 (CET)
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org

This series adds sound support for the Cirrus Logic CLPS711X CPUs.
Driver is designed (and tested) for using with generic sound card.

Alexander Shiyan (2):
  ASoC: Add driver for CLPS711X DAI interface
  ASoC: cirrus: clps711x: Add bindings documentation for the CLPS711X
    DAI

 .../bindings/sound/cirrus,clps711x-dai.txt         |  20 +
 sound/soc/cirrus/Kconfig                           |   8 +
 sound/soc/cirrus/Makefile                          |   5 +
 sound/soc/cirrus/clps711x-dai.c                    | 522 +++++++++++++++++++++
 sound/soc/cirrus/clps711x-dai.h                    |  61 +++
 sound/soc/cirrus/clps711x-fiq.S                    |  56 +++
 6 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,clps711x-dai.txt
 create mode 100644 sound/soc/cirrus/clps711x-dai.c
 create mode 100644 sound/soc/cirrus/clps711x-dai.h
 create mode 100644 sound/soc/cirrus/clps711x-fiq.S

-- 
1.8.3.2
