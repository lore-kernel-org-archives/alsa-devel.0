From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ASoC: trivial compile warning fixes
Date: Mon,  6 May 2019 17:02:21 +0200
Message-ID: <20190506150224.1394-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F986F89673
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:02:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

here are the three fixes for trivial compile warnings I caught during
build test.


Takashi

===

Takashi Iwai (3):
  ASoC: da7219: Fix a compile warning at CONFIG_COMMON_CLK=n
  ASoC: SOF: Fix a compile warning with CONFIG_PCI=n
  ASoC: rockchip: Fix an uninitialized variable compile warning

 sound/soc/codecs/da7219.c         | 2 ++
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 sound/soc/sof/ops.c               | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.16.4
