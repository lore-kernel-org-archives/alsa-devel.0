From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/7] ASoC: Cleanup AC'97 reset handling
Date: Tue, 21 Jul 2015 21:52:59 +0200
Message-ID: <1437508386-13828-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2BA26510F
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 21:53:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

AC'97 devices require that they are properly reset before they can be used.
Currently ASoC drivers do this by hand each on its own. This lead to many
similar but slightly different implementations. E.g. Some supporting warm
reset, some don't. And even though AC'97 do have a device ID which uniquely
identifies a device most drivers only use the content of register 0 for
device verification.

This patch series introduces a new generic helper function in the ALSA
AC'97 core that can be used to reset a device and verify its ID if
required. And then converts drivers to use this new helper function instead
of custom code.

snd_soc_new_ac97_codec() is extended to be able to perform a reset between
the allocation and registration of the AC'97 device, this will allow more
drivers to use it.

- Lars

Lars-Peter Clausen (7):
  ALSA: ac97: Add helper function to reset the AC97 device
  ASoC: ac97: Add support for resetting device before registration
  ASoC: ad1980: Use core AC'97 reset helper
  ASoC: stac9766: Use core reset helper
  ASoC: wm9705: Use core AC'97 reset helper
  ASoC: wm9712: Use core AC'97 reset helper
  ASoC: wm9713: Use core AC'97 reset helper

 include/sound/ac97_codec.h  |  2 ++
 include/sound/soc.h         |  3 ++-
 sound/ac97_bus.c            | 62 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1980.c   | 36 +++++++++-----------------
 sound/soc/codecs/stac9766.c | 57 +++++------------------------------------
 sound/soc/codecs/wm9705.c   | 40 ++++++-----------------------
 sound/soc/codecs/wm9712.c   | 45 ++++++--------------------------
 sound/soc/codecs/wm9713.c   | 48 ++++++-----------------------------
 sound/soc/codecs/wm9713.h   |  2 --
 sound/soc/soc-ac97.c        | 30 ++++++++++++++++++----
 10 files changed, 134 insertions(+), 191 deletions(-)

-- 
2.1.4
