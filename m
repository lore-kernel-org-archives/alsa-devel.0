From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: davinci-mcasp: Correct start
	sequences for TX/RX
Date: Fri, 28 Mar 2014 09:18:28 +0200
Message-ID: <1395991110-19280-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 947612617BB
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 08:18:37 +0100 (CET)
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

The startup sequence for TX and RX was not correct, not following the
programming sequence from the TRM.
This could cause initial channel swap when starting TX.

The change has been tested on AM335x and AM437x but it should be valid for all
devices.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: davinci-mcasp: Correct TX start sequence
  ASoC: davinci-mcasp: Correct RX start sequence

 sound/soc/davinci/davinci-mcasp.c | 37 +++++++++++++------------------------
 sound/soc/davinci/davinci-mcasp.h |  6 ++++++
 2 files changed, 19 insertions(+), 24 deletions(-)

-- 
1.9.1
