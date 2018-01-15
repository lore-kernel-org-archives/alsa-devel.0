From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/5] ASoC: (minor) atmel cleanup
Date: Mon, 15 Jan 2018 08:52:13 +0100
Message-ID: <20180115075213.GA10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id C0EEF26731C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 08:52:15 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990477AbeAOHwOOV0pu (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 15 Jan 2018 08:52:14 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi there!

this patchset is a side product of reading ALSA code while trying to support
new hardware. Nothing special here, just an attempt to make those three
drivers to look more similar. Only patch 4 fixes actual problem, but:
1) this particular issue is present almost everywhere (as far as I looked)
   where of_node_put is used in ALSA. Perhaps coccinelle people could help?
2) seems noone bothered as OF_DYNAMIC is mostly disabled

Compile tested only.

Ladislav Michl (5):
  ASoC: sam9g20_wm8731: use dev_*() logging functions
  ASoC: sam9x5_wm8731: Drop 'ASoC' prefix from error messages
  ASoC: sam9x5_wm8731: Return -ENODEV when probe does not find OF node
  ASoC: sam9x5_wm8731: Fix OF node reference counting
  ASoC: atmel_wm8904: Return -ENODEV when probe does not find OF node
  
 sound/soc/atmel/atmel_wm8904.c   |  6 ++----
 sound/soc/atmel/sam9g20_wm8731.c | 17 +++++++--------
 sound/soc/atmel/sam9x5_wm8731.c  | 45 +++++++++++++++++-----------------------
 3 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.15.1
