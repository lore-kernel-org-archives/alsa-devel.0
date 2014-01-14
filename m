From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 0/3] ASoC: atmel_ssc_dai: add option to choose
	clock
Date: Tue, 14 Jan 2014 11:25:53 +0800
Message-ID: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B8D32610B5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 04:27:20 +0100 (CET)
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
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-doc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, plagnioj@jcrosoft.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-sound@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Landley <rob@landley.net>
List-Id: alsa-devel@alsa-project.org

When SSC work in slave mode, the clock can come from TK pin and also
can come from RK pin, this is hardware design decided. So, make it
available to choose where the clock from.


Bo Shen (3):
  ASoC: atmel_ssc_dai: make option to choose clock
  ASoC: atmel_wm8904: make it available to choose clock
  Binding: atmel-wm8904: add option to choose clock

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt |  2 ++
 sound/soc/atmel/atmel_ssc_dai.c                          | 16 ++++++++++++----
 sound/soc/atmel/atmel_ssc_dai.h                          |  1 +
 sound/soc/atmel/atmel_wm8904.c                           | 10 ++++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.8.5.2
