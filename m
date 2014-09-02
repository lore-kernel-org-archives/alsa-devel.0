From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/5] ASoC: Remove unnecessary suspend/resume
	bias level changes
Date: Tue,  2 Sep 2014 22:20:29 +0200
Message-ID: <1409689234-14774-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 253442654BC
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 22:20:41 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

There are a handful of drivers which do set idle_bias_level = true, but at the
same time implement suspend and resume handlers which do bias level transitions 
to OFF in suspend and to STANDBY in resume. Since the ASoC core will only
suspend a CODEC if it is idle this means that drivers that set idle_bias_level =
true will already be at bias level OFF when suspend is called, which makes the
manual transition unnecessary. On the other hand manual transition to STANDBY in
resume will be reverted by the core going back to OFF after the resume handler
has run. So the manual bias level change in resume is also unnecessary and can
cause additional IO operations.

This series removes all those unnecessary manual bias level transitions.

- Lars

Lars-Peter Clausen (5):
  ASoC: adau1373: Remove unnecessary suspend/resume bias level changes
  ASoC: lm49453: Remove unnecessary suspend/resume bias level changes
  ASoC: tlv320aic3x: Remove unnecessary suspend/resume bias level
    changes
  ASoC: wm8804: Remove unnecessary suspend/resume bias level changes
  ASoC: wm8995: Remove unnecessary suspend/resume bias level changes

 sound/soc/codecs/adau1373.c    | 14 --------------
 sound/soc/codecs/lm49453.c     | 14 --------------
 sound/soc/codecs/tlv320aic3x.c | 16 ----------------
 sound/soc/codecs/wm8804.c      | 19 -------------------
 sound/soc/codecs/wm8995.c      | 19 -------------------
 5 files changed, 82 deletions(-)

-- 
1.8.0
