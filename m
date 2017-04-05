From: simon.ho.cnxt@gmail.com
Subject: [PATCH v4 0/2] ASoC: add driver support for CX2092X DSP
Date: Wed,  5 Apr 2017 18:27:11 +0800
Message-ID: <cover.1491387037.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DDAF266FE6
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:27:19 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id 197so1325445pfv.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 03:27:18 -0700 (PDT)
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
Cc: pierre-louis.bossart@linux.intel.com, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Hi Pierre, Mark and Takashi

I corrected the driver based on your input as below.

  - Corrected coding style.
  - Removed ".owner" assignment.
  - Removed SPI interface support since SPI fearure is removed from this 
    new chip.
  
Thanks,

Simon

Simon Ho (2):
  doc: cx2092x: Add DT bingings doc for CX2092X DSP
  ASoC: Add support for Conexant CX2092X DSP

 .../devicetree/bindings/sound/cnxt,cx2092x.txt     |  25 ++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/cx2092x.c                         | 436 +++++++++++++++++++++
 sound/soc/codecs/cx2092x.h                         |  19 +
 5 files changed, 488 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
 create mode 100644 sound/soc/codecs/cx2092x.c
 create mode 100644 sound/soc/codecs/cx2092x.h

-- 
2.7.4
