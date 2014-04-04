From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/7] ASoC:davinci-mcasp: bc polarity fix and
	proper format support
Date: Fri, 4 Apr 2014 14:31:40 +0300
Message-ID: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 69BA32657CE
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:31:53 +0200 (CEST)
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

The bit clock polarity has been configured incorrectly in the McASP driver for a
long time. IB_NF, NB_IF and IB_IF was not correct on the receive side since they
were selecting the same edge as we used for the tx.

The driver only had support for DSP_B mode (and probably AC97, but I can not
test that). All other formats were broken (DSP_A, I2S, LEFT_J, etc).
With this series the following formats will be supported by the McASP driver:
- DSP_B
- AC97
- DSP_A (new)
- I2S (new)
- LEFT_J (new)

Non supported modes will return error from now on.

Regards,
Peter
---
Peter Ujfalusi (7):
  ASoC: davinci-mcasp: Fix bit clock polarity settings
  ASoC: davinci-mcasp: Format data delay configuration enhancement
  ASoC: davinci-mcasp: Support for DSP_A format
  ASoC: davinci-mcasp: Move the FS polarity change out from the switch
    case
  ASoC: davinci-mcasp: Add support for I2S format
  ASoC: davinci-mcasp: Support for LEFT_J format
  ASoC: davinci-mcasp: Remove excess empty lines from
    davinci_mcasp_set_dai_fmt()

 sound/soc/davinci/davinci-mcasp.c | 76 +++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 26 deletions(-)

-- 
1.9.1
