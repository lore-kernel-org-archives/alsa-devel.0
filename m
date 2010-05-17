From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: tlv320dac33: small power handling
	updates
Date: Mon, 17 May 2010 14:21:44 +0300
Message-ID: <1274095306-24838-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B62D245F0
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 13:21:52 +0200 (CEST)
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
Cc: felipe.balbi@nokia.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

While testing suspend, it has been noticed, that the driver would
try to power off the codec more than once.
Since this case handled in the driver, and results no functional
defect we can lower the noise in the kernel log.

Also avoid the root cause of the multiple off calls by filtering
BIAS_OFF request when the codec was already OFF.

---
Felipe Balbi (1):
  ASoC: tlv320dac33: Use dev_dbg in dac33_hard_power function

Peter Ujfalusi (1):
  ASoC: tlv320dac33: Avoid powering off while in BIAS_OFF

 sound/soc/codecs/tlv320dac33.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)
