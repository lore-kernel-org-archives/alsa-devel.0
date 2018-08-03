From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] ALSA: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:32 +0200
Message-ID: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FC452677BC
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:43 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E9317AD85
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 14:33:42 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patchset of trivial cleanups I noticed while working on the
recent sequencer bug.  There are a bunch of driver codes that have
empty module init and exit entries, and we can remove them
gracefully.


Takashi

===

Takashi Iwai (6):
  ALSA: compress: Remove empty init and exit
  ALSA: drivers: Remove empty init and exit
  ALSA: isa: Remove empty init and exit
  ALSA: i2c: Remove empty init and exit
  ALSA: pci: Remove empty init and exit
  ALSA: synth: Remove empty init and exit

 sound/core/compress_offload.c      | 12 ------------
 sound/drivers/mpu401/mpu401_uart.c | 16 ----------------
 sound/drivers/opl3/opl3_lib.c      | 16 ----------------
 sound/drivers/opl4/opl4_lib.c      | 12 ------------
 sound/drivers/vx/vx_core.c         | 15 ---------------
 sound/i2c/cs8427.c                 | 12 ------------
 sound/i2c/i2c.c                    | 13 -------------
 sound/i2c/other/ak4xxx-adda.c      | 12 ------------
 sound/i2c/tea6330t.c               | 16 ----------------
 sound/isa/es1688/es1688_lib.c      | 16 ----------------
 sound/isa/gus/gus_main.c           | 16 ----------------
 sound/isa/sb/sb16_csp.c            | 16 ----------------
 sound/isa/sb/sb16_main.c           | 16 ----------------
 sound/isa/sb/sb8_main.c            | 16 ----------------
 sound/isa/sb/sb_common.c           | 16 ----------------
 sound/isa/wss/wss_lib.c            | 16 ----------------
 sound/pci/ac97/ac97_codec.c        | 16 ----------------
 sound/pci/ice1712/ak4xxx.c         | 12 ------------
 sound/synth/emux/emux.c            | 17 -----------------
 sound/synth/util_mem.c             | 16 ----------------
 20 files changed, 297 deletions(-)

-- 
2.18.0
