From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 0/2] ASoC: core: Option to reorder widget power
	sequence
Date: Thu,  2 Dec 2010 14:03:08 +0200
Message-ID: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id E4403103A6F
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:03:16 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

Quite some time ago I have faced similar issue with the sequence of the
DAPM register writes [1]
For that issue, I used a workaround within the twl4030 codec driver.
Now I have again issue with the register write sequence.

The dac33 codec emmits a pop noise, when user enable the analog bypass path.
The route cause in this codec are the DAPM update power and register write
sequence:
1. User enable the bypass
2. DAPM power up sequence takes place
2.1 codec DAPM widgets got powered on, codec is enabled
2.2 External speaker enabled
3. The bit enabling the bypass got changed.

Step 3 cause a pop, which propagate to the speaker, since it is already enabled.

The first patch implements a new flag for the core to reorder the sequence to:
1. User enable the bypass
2. The bit enabling the bypass got changed.
3. DAPM power up sequence takes place
3.1 codec DAPM widgets got powered on, codec is enabled
3.2 External speaker enabled

The default sequence is kept, codec driver must ask to have the reordered
sequence to avoid any side effect on other codecs.

[1]: http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030024.html

Peter

---
Peter Ujfalusi (2):
  ASoC: core: Reordered DAPM update power on widgets
  ASoC: tlv320dac33: Request for reordered update power sequence

 include/sound/soc-dapm.h       |    1 +
 sound/soc/codecs/tlv320dac33.c |    1 +
 sound/soc/soc-dapm.c           |   27 +++++++++++++++++++--------
 3 files changed, 21 insertions(+), 8 deletions(-)

-- 
1.7.3.2
