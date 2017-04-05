From: simon.ho.cnxt@gmail.com
Subject: [PATCH v2 0/2] ASoC: add support for CX2072X CODEC
Date: Wed,  5 Apr 2017 17:07:12 +0800
Message-ID: <cover.1491382907.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6049C266FA1
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 11:07:19 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id o123so1250821pga.1
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 02:07:19 -0700 (PDT)
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

Hi Takashi, Mark

I corrected the driver based on your input as below. Please help review the
code.

Mark:
 - Corrected the coding style.
 - EQ/DRC settings can be configured from userspace via mixer controls.
 - Wrongly cast void pointers.
 - Print I2C error code.
 - Use memcmp() to check if the new EQ value is different. 
 - Removed unused TDM code.
 - Removed noisy "out of memory" message.
 - Corrected ACPI and I2C match table.
 - Removed unnessary CONFIG_ACPI define.

Takashi: 
 - Fixed printf int argument.
 - Fixed unexpected error code at no MCLK fallback.

Thanks,

Simon

Simon Ho (2):
  ASoC: cx2072x: Add DT bingings documentation for CX2072X CODEC
  ASoC: add support for Conexant CX2072X CODEC

 .../devicetree/bindings/sound/cx2072x.txt          |   36 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cx2072x.c                         | 2253 ++++++++++++++++++++
 sound/soc/codecs/cx2072x.h                         |  319 +++
 5 files changed, 2615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cx2072x.txt
 create mode 100644 sound/soc/codecs/cx2072x.c
 create mode 100644 sound/soc/codecs/cx2072x.h

-- 
2.7.4
