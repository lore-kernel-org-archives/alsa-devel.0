From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 0/4] add da9034 audio support for Littleton and
	generalize SSP I2S/LeftJ
Date: Wed, 3 Jun 2009 20:32:40 +0800
Message-ID: <f17812d70906030532x10aea8beo455ae63bda6bc26b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 658DC2437F
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:32:41 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so4900781qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:32:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Thanks for Paul's good work, and finally, we worked together to
figure out the generalized I2S/LeftJ support in current pxa-ssp.c,
and added the audio support for Littleton:

Here's the summary:

Paul Shen (4):
      ASoC: pxa-ssp: enhance I2S and add Left_J support
      ASoC: add dialog da9034 (aka micco) audio codec support
      ASoC: pxa add Marvell Littleton platform audio support
      [ARM] pxa/littleton: add support for audio (da9034)

 arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 +-
 arch/arm/mach-pxa/littleton.c             |   20 +-
 include/linux/mfd/da903x.h                |    1 +
 sound/soc/codecs/Kconfig                  |    4 +
 sound/soc/codecs/Makefile                 |    2 +
 sound/soc/codecs/da9034-audio.c           |  696 +++++++++++++++++++++++++++++
 sound/soc/pxa/Kconfig                     |    9 +
 sound/soc/pxa/Makefile                    |    2 +
 sound/soc/pxa/littleton.c                 |  228 ++++++++++
 sound/soc/pxa/pxa-ssp.c                   |   62 ++--
 sound/soc/pxa/pxa-ssp.h                   |    9 +
 11 files changed, 1008 insertions(+), 39 deletions(-)


-- 
Cheers
- eric
