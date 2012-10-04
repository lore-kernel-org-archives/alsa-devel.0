From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/5] McASP changes for more flexibility
Date: Thu,  4 Oct 2012 15:08:37 +0200
Message-ID: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF1A261631
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:11 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I've been working on the McASP driver lately to support a board on
which an AM33xx SoC is connected to a CS4271 via I2S. The CPU is clock
master for both LRCLK and BITCLK, but receives its master clock
externally.

Some changes were necessary in order to get this playing, as the
driver seems to have been used with DSP_B formats only.

I couldn't the pateches on any Davinci platform, so I rely on other
people to test and see if they break anything.


Thanks,
Daniel

Daniel Mack (5):
  ALSA: ASoC: enable 192KHz support for McASP
  ALSA: ASoC: McASP: add support for clock dividers
  ALSA: ASoC: McASP: add support for 24 bit samples
  ALSA: ASoC: McASP: make AHCLK direction configurable
  ALSA: ASoC: McASP: set format parameters in dependence of the DAI
    format

 sound/soc/davinci/davinci-evm.c   |  5 +++
 sound/soc/davinci/davinci-mcasp.c | 87 ++++++++++++++++++++++++++++++++++-----
 sound/soc/davinci/davinci-mcasp.h |  2 +-
 sound/soc/davinci/davinci-pcm.c   | 16 ++-----
 4 files changed, 86 insertions(+), 24 deletions(-)

-- 
1.7.11.4
