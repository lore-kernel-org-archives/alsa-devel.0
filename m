From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 0/3] ASoC AC97 generic glue patches
Date: Wed, 13 Oct 2010 11:30:30 +0300
Message-ID: <cover.1286958072.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FC01039F0
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:30:26 +0200 (CEST)
Received: by bwz18 with SMTP id 18so3567297bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 01:30:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

While I was porting ep93xx-ac97 driver to multicomponent ASoC, I encountered few
issues with the generic AC97 glue driver (which we are using with Sim.One). This
series tries to fix those.

Regards,
MW

Mika Westerberg (3):
  ASoC: ac97: don't call snd_soc_new_ac97_codec at probe
  ASoC: don't register AC97 devices twice
  ASoC: ac97: add MODULE_ALIAS for the platform driver

 include/sound/soc.h     |    1 +
 sound/soc/codecs/ac97.c |    7 +------
 sound/soc/soc-core.c    |   18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)
