From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] ASoC: make snd_soc_dai_driver and
	snd_soc_component_driver const
Date: Wed, 16 Aug 2017 22:45:07 +0530
Message-ID: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id C47DC266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 19:15:27 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id 123so5680584pga.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 10:15:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, rjui@broadcom.com, sbranden@broadcom.com, jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const.

Bhumika Goyal (2):
  ASoC: bcm: make snd_soc_dai_driver const
  ASoC: codecs: make snd_soc_dai_driver and snd_soc_component_driver
    const

 sound/soc/bcm/cygnus-ssp.c    | 2 +-
 sound/soc/codecs/hdmi-codec.c | 2 +-
 sound/soc/codecs/lm4857.c     | 2 +-
 sound/soc/codecs/max9768.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
