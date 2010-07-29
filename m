From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 0/4] ASoC: OMAP3: Extended threshold mode
Date: Thu, 29 Jul 2010 09:51:24 +0300
Message-ID: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A808210392B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 08:51:28 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

The following series extends the current threshold implementation for OMAP3
class of devices.

The original threshold implementation has limitation on the size of the period,
which can not be bigger than the McBSP port's FIFO size.
This limitation makes it hard to use any power saving on McBSP ports other than
McBSP2 (McBSP2 has 1280 word buffer, other ports have only 128 word long
buffer), since the maximum period size limit is really small.

After the series the limitation on the period size can be lifted, so user space
can ask for any period size on any of the McBSP ports.

In order to achieve this, I introduce the following changes, when McBSP is in
threshold mode:

if (period_words <= max_threshold)
Configure the McBSP/sDMA as it used to be:
McBSP threshold = sDMA frame size = period size
sDMA packet size = 0

Otherwise (period_words > max_threshold)
McBSP threshold = sDMA packet size
sDMA frame size = period size

In this case the code will look for the biggest possible threshold value, which
can evenly divide the period size, and use that for threshold/packet size.

The first two patch is for preparation.

The series has been generated against:
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git:topic/asoc

What do you think?

---
Peter Ujfalusi (4):
  ASoC: omap-mcbsp: Code cleanup in omap_mcbsp_dai_hw_params
  ASoC: omap-mcbsp: Restructure the code within
    omap_mcbsp_dai_hw_params
  ASoC: omap-mcbsp: Support for sDMA packet mode
  ASoC: omap-mcbsp: Remove period size constraint in THRESHOLD mode

 sound/soc/omap/omap-mcbsp.c |  137 ++++++++++++++++++++++++-------------------
 1 files changed, 76 insertions(+), 61 deletions(-)

--
1.7.2
