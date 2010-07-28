From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 0/2] ASoC: tlv320dac33: FIFO mode updates
Date: Wed, 28 Jul 2010 15:26:53 +0300
Message-ID: <1280320015-16099-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C381724440
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 14:27:18 +0200 (CEST)
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

Changes since v1:
- mode1_i2c_latecy renamed to mode1_latency

Intro mail from the first series:

The main feature of this series is the automatic FIFO configuration of the FIFO,
when one of the FIFO mode is selected.
The first patch simplifies the handling of the Mode1 in manual mode, and also
removes the hardwired latency definition from the code, so it can be adjusted
based on the underlying platform.

The second patch adds option to select the automatic FIFO configuration.
When this mode is selected the driver will configure the FIFO to match the
stream's period size with the burst length (in terms of samples bursted out from
the host).
In Mode1 this is trivial, since I can configure the nSample to match with the
period size. However the Mode7 is a bit more complicated. The formula
(UTHR_FROM_PERIOD_SIZE) calculates the UTHR configuration for the given number
of samples.

The patches are generated against:
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git:topic/asoc

---
Peter Ujfalusi (2):
  ASoC: tlv320dac33: Revisit the FIFO Mode1 handling
  ASoC: tlv320dac33: Add support for automatic FIFO configuration

 include/sound/tlv320dac33-plat.h |    2 +
 sound/soc/codecs/tlv320dac33.c   |  125 ++++++++++++++++++++++++--------------
 2 files changed, 82 insertions(+), 45 deletions(-)

--
1.7.2
