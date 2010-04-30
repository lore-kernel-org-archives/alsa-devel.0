From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 0/4] ASoC: tlv320dac33: Support for turning
	off codec
Date: Fri, 30 Apr 2010 14:59:32 +0300
Message-ID: <1272628776-23185-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 97FE0103934
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 14:00:02 +0200 (CEST)
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
- patch 1: Removed extra register writes
- patch 4:
 - Let core to bring the codec to BIAS_OFF (set idle_bias_off)
 - dac33_set_bias_level only takes care of power and minimum initialization
 - PRE_DAPM widget event is replacing the dac33_pcm_pointer call to take
   care of the initialization needed before _every_ playback.

There are few scenarios, which has to be taken care::
1. Analog bypass caused BIAS_OFF -> BIAS_ON
   We need to power on the codec, and do the chip init, but we does not
   need to execute the playback related configuration
2. Playback caused  BIAS_OFF -> BIAS_ON
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

Since the power up, and the codec init is optimized, the added overhead
in stream start is minimal.

Withing this patch, the hard_power function is now only doing what it
supposed to: only handle the powers, and GPIO reset line.
The codec initialization and state restore has been moved out.

---
Peter Ujfalusi (4):
  ASoC: tlv320dac33: Optimize power up, and restore
  ASoC: tlv320dac33: Revised module loading, and DAC33 ID read
  ASoC: tlv320dac33: Manage a pointer for snd_pcm_substream in private
    structure
  ASoC: tlv320dac33: Support for turning off the codec

 sound/soc/codecs/tlv320dac33.c |  235 ++++++++++++++++++++++------------------
 1 files changed, 129 insertions(+), 106 deletions(-)
