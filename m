From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/7] ASoC: remove bitwise operations on GPIO
	level value
Date: Tue,  2 Jun 2015 02:07:11 +0300
Message-ID: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C16260425
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:07:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The series does not contain any functional changes, it touches only
implementation of gpiolib .set and .direction_output callbacks.

The main intention of the change is to remove bitwise operations on
GPIO high/low level value as a preceding change before updating
gpiolib callback signatures to utilize bool type as a representation
of GPIO level.

The change covers all input cases of GPIO level (i.e. .set
and .direction_output) in sound/*, also the series contains a small
clean-ups in rt5677 and wm8903 codec drivers related to gpiolib
callbacks.

Vladimir Zapolskiy (7):
  ASoC: rt5677: add GPIO helper macros
  ASoC: rt5677: clean up gpiolib callbacks
  ASoC: wm8903: generalize GPIO control register bits
  ASoC: wm8903: simplify gpiolib callbacks
  ASoC: wm5100: remove bitwise operations involving GPIO level value
  ASoC: wm8962: remove bitwise operations involving GPIO level value
  ASoC: wm8996: remove bitwise operations involving GPIO level value

 include/sound/wm8903.h    | 222 ++++++++--------------------------------------
 sound/soc/codecs/rt5677.c |  32 +++++--
 sound/soc/codecs/rt5677.h |   6 ++
 sound/soc/codecs/wm5100.c |  21 ++---
 sound/soc/codecs/wm8903.c |  44 ++++-----
 sound/soc/codecs/wm8962.c |  13 ++-
 sound/soc/codecs/wm8996.c |  11 ++-
 7 files changed, 112 insertions(+), 237 deletions(-)

-- 
2.1.4
