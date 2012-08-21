From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: omap-mcbsp: Sidetone related changes
Date: Tue, 21 Aug 2012 17:42:00 +0300
Message-ID: <1345560123-23959-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
 [74.125.149.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A970265FE9
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:42:16 +0200 (CEST)
Received: by eekb57 with SMTP id b57so1917188eek.34
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 07:42:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello,

When we boot with DT blob the sidetone is not supported at the moment. Prepare
the McBSP code for the time when we are going to be able to support ST with DT
booted kernel.
Meanwhile do not block the audio card if the st_data is missing from the port,
but print a warning about it. This will allow us to debug the DT booted kernels
with audio.

Mark: This series as such does not depend on the McBSP DT support, but it can be
attached to that branch.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: omap-mcbsp: Check mcbsp->id instead of cpu_dai->id when adding
    ST controls
  ASoC: omap-mcbsp: Only print warning if the st_data is missing for
    the port
  ASoC: omap-mcbsp: Use macro to create the McBSP2/3 ST controls

 sound/soc/omap/omap-mcbsp.c |   47 ++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

-- 
1.7.8.6
