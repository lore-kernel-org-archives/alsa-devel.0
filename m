From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/4] ASoC: tlv320dac33: Support for turning
	codec off
Date: Fri, 30 Apr 2010 10:31:51 +0300
Message-ID: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BF6121037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 09:32:02 +0200 (CEST)
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

The following series adds support for turning the tlv320dac33 codec off in
BIAS_STANDBY (and obviously in BIAS_OFF).

Since the driver already had mechanics for supporting turned off codec in
register writes, the needed changes are mainly in the BIAS/stream handling.

As part of the series further optimization has been done to codec
initialization, resume.

The following scenarios has been tested, and verified (I think these are
covering all cases):
1. Analog bypass caused BIAS_STANDBY -> BIAS_ON
   We need to power on the codec, and do the chip init, but we does not
   need to execute the playback related configuration
2. Playback caused  BIAS_STANDBY -> BIAS_ON
   We need to power on the codec, and do the chip init, and also we need
   to execute the playback related configuration.
3. Playback start, while Analog bypass is on (BIAS_ON -> BIAS_ON)
   We need to execute the playback related configuration. The codec is
   already on.
4. Analog bypass enable, while playback (BIAS_ON -> BIAS_ON)
   Nothing need to be done.
5. Playback start withing soc power down timeout (BIAS_ON -> BIAS_ON)
   We need to execute the playback related configuration. The codec is
   still on.
6. Analog bypass enable withing soc power down timeout (BIAS_ON -> BIAS_ON)
   Nothing need to be done.

This series applies on top of Liam's:
git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.35 branch

---
Peter Ujfalusi (4):
  ASoC: tlv320dac33: Optimize power up, and restore
  ASoC: tlv320dac33: Revised module loading, and DAC33 ID read
  ASoC: tlv320dac33: Manage a pointer for snd_pcm_substream in private
    structure
  ASoC: tlv320dac33: Support for turning off the codec in BIAS_STANDBY

 sound/soc/codecs/tlv320dac33.c |  236 +++++++++++++++++++++++-----------------
 1 files changed, 137 insertions(+), 99 deletions(-)
