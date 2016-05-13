From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] Add support for trigger only voice
	recognition
Date: Fri, 13 May 2016 16:45:14 +0100
Message-ID: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6214F265370
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:45:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

In some systems our voice trigger firmwares will be used only to
provide an event that indicates the trigger phrase was spoken,
this patch chain adds support for this use-case. There are two
parts to adding this support firstly, a mechanism is required
to get the DSP to power on without the compressed stream being
opened, this is done by means of a virtual output for the voice
trigger in the DAPM graph. Secondly, the trigger event needs to
be handled. Typically this will be used to generate a key press
event, but there are numerous options what could be done here,
and vendors often have their own rather strong opinions.  Rather
than dictate the usage at the driver level we we simply provide a
notifier that can be caught in the machine driver and appropriate
action can be taken there.

Thanks,
Charles

Charles Keepax (5):
  ASoC: arizona: Tie SYSCLK to DRC signal activity widgets
  ASoC: arizona: Add voice trigger output widget
  ASoC: wm_adsp: Specifically propagate voice trigger event to caller
  ASoC: arizona: Add a notifier chain for CODEC events
  ASoC: arizona: Add event notification on voice trigger events

 include/linux/mfd/arizona/core.h | 10 ++++++++++
 sound/soc/codecs/arizona.c       | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h       | 15 ++++++++++++++
 sound/soc/codecs/cs47l24.c       | 16 +++++++++++++++
 sound/soc/codecs/wm5102.c        |  1 +
 sound/soc/codecs/wm5110.c        | 16 +++++++++++++++
 sound/soc/codecs/wm8998.c        |  1 +
 sound/soc/codecs/wm_adsp.c       |  5 +++++
 sound/soc/codecs/wm_adsp.h       |  4 ++++
 9 files changed, 111 insertions(+)

-- 
2.1.4
