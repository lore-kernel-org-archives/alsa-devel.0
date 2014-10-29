From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v03 0/4] ASoC: davinci-mcasp: Correct
	start/stop sequences
Date: Wed, 29 Oct 2014 13:55:43 +0200
Message-ID: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE4C2604FF
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:55:53 +0100 (CET)
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

For some reason these patches did not made it to mainline kernel. V2 was sent
on 28.04.2014:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074871.html
and got applied the same day:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074878.html

I just noticed that they are missing.

Changes since v2:
- rebased on next

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
2.1.2
