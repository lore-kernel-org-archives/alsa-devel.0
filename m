From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: davinci-mcasp: Fix master mode
	capture (w/o playback)
Date: Thu, 30 Jan 2014 15:15:21 +0200
Message-ID: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D88D265378
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:15:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

When McASP is master the TX clocks are used for capture clocking as well. Other
parts of the code already does the configuration for both tx and rx - for
different bits in xxFMT/xxFMCT registers we should do the same in other places.

Along with this fix I have added three cleanup patch which came along when I was
debugging the issue.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Harmonize the sub hw_params function names
  ASoC: davinci-mcasp: Configure xxTDM, xxFMT and xxFMCT registers
    synchronously
  ASoC: davinci-mcasp: Return value handling cleanup for
    mcasp_common_hw_param()
  ASoC: davinci-mcasp: Code cleanup in davinci_mcasp_hw_params()

 sound/soc/davinci/davinci-mcasp.c | 81 +++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

-- 
1.8.5.3
