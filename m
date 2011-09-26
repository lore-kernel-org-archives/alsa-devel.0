From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 0/4] ASoC: omap-mcpdm/twl6040: Offset
	cancellation
Date: Mon, 26 Sep 2011 16:05:55 +0300
Message-ID: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 65CF524393
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:06:20 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so8040027bke.11
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:06:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following series adds support for the McPDM offset cancellation feature.
It provides the needed functionality to:
- read the HSTRIM values from the twl6040 codec
- configure the offset cancellation registers in OMAP-McPDM

Rebased batches on top of:
git://opensource.wolfsonmicro.com/linux-2.6-asoc, for-3.2 branch

No other changes.

Mark: I have not added you acks to the patches, since you will be signing them
off anyways.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: twl6040: Read the TRIM values from the chip
  ASoC: twl6040: Function to fetch the TRIM values
  ASoC: omap-mcpdm: API to configure offset cancellation
  ASoC: sdp4430: Configure McPDM offset cancellation

 sound/soc/codecs/twl6040.c  |   16 ++++++++++++++++
 sound/soc/codecs/twl6040.h  |   13 +++++++++++++
 sound/soc/omap/omap-mcpdm.c |   25 +++++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   12 ++++++++++++
 sound/soc/omap/sdp4430.c    |   10 +++++++++-
 5 files changed, 75 insertions(+), 1 deletions(-)

-- 
1.7.6.1
