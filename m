From: simon.ho.cnxt@gmail.com
Subject: [PATCH v5 0/2] ASoC: Add support for Conexant CX2092X
	DSP
Date: Thu,  6 Apr 2017 11:04:32 +0800
Message-ID: <cover.1491446448.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BD752267218
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 05:04:39 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id 79so5179723pgf.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 20:04:39 -0700 (PDT)
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
Cc: pierre-louis.bossart@linux.intel.com, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Thanks to Charles' review, this fixed things were pointed by him. 

Changes with v4:
	- Changed lable name to lower case.
	- Uses non-blocking sleep function msleep() instead of mdelay(). 
	- Fixed incorrect return code when sendcmd operation fails. 

Simon Ho (2):
  doc: cx2092x: Add DT bingings doc for CX2092X DSP
  ASoC: Add support for Conexant CX2092X DSP

 .../devicetree/bindings/sound/cnxt,cx2092x.txt     |  25 ++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/cx2092x.c                         | 440 +++++++++++++++++++++
 sound/soc/codecs/cx2092x.h                         |  19 +
 5 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
 create mode 100644 sound/soc/codecs/cx2092x.c
 create mode 100644 sound/soc/codecs/cx2092x.h

-- 
2.7.4
