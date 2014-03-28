From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] ASoC: davinci-mcasp: Correct start/stop
	sequences
Date: Fri, 28 Mar 2014 11:25:13 +0200
Message-ID: <1395998717-27067-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B9FB026549F
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 10:25:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v1:
- Correction for the stop sequence is added
- start code cleanup patch added

The startup sequence for TX and RX was not correct, not following the
programming sequence from the TRM.
This could cause initial channel swap when starting TX.
When stopping the stream the AFIFO should be stopped as the last step to avoid
unpredictable behavior.

The change has been tested on AM335x and AM437x but it should be valid for all
devices.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Correct TX start sequence
  ASoC: davinci-mcasp: Correct RX start sequence
  ASoC: davinci-mcasp: When stopping TX/RX stop the AFIFO as the last
    step
  ASoC: davinci-mcasp: Move the AFIFO related code under start_tx/rx
    functions

 sound/soc/davinci/davinci-mcasp.c | 95 ++++++++++++++++++---------------------
 sound/soc/davinci/davinci-mcasp.h |  6 +++
 2 files changed, 49 insertions(+), 52 deletions(-)

-- 
1.9.1
