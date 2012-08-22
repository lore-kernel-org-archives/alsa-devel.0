From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] ASoC: omap-mcbsp: Sidetone related
	changes
Date: Wed, 22 Aug 2012 13:11:39 +0300
Message-ID: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
 [74.125.149.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA312660DC
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:11:55 +0200 (CEST)
Received: by obbwc20 with SMTP id wc20so1553004obb.17
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:11:54 -0700 (PDT)
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

Changes since v1:
- Macro for the ST control has been fixed
- New patch to combine the st channel volume set/get macros

Mark: this series depends on the McBSP DT support (to be precise patch 3 and 4
has dependency).

Intro mail from v1:

When we boot with DT blob the sidetone is not supported at the moment. Prepare
the McBSP code for the time when we are going to be able to support ST with DT
booted kernel.
Meanwhile do not block the audio card if the st_data is missing from the port,
but print a warning about it. This will allow us to debug the DT booted kernels
with audio.

Regards,
Peter
---

Peter Ujfalusi (4):
  ASoC: omap-mcbsp: Check mcbsp->id instead of cpu_dai->id when adding
    ST controls
  ASoC: omap-mcbsp: Only print warning if the st_data is missing for
    the port
  ASoC: omap-mcbsp: Use macro to create the McBSP2/3 ST controls
  ASoC: omap-mcbsp: Single macro for st channel volume set/get

 sound/soc/omap/omap-mcbsp.c |   64 ++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 37 deletions(-)

-- 
1.7.8.6
