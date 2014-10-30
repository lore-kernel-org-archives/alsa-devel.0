From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/14] ASoC: AC'97 driver cleanups
Date: Thu, 30 Oct 2014 21:00:57 +0100
Message-ID: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C24B2606F4
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:15 +0100 (CET)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

This series does a few AC'97 driver cleanups in preparation of the
conversion of the drivers to regmap. Most of the patches are quite trivial.

The last two patches remove the virtual registers from the wm9712 and wm9713
drivers, which is a requirement for regmap conversion.

The last patch is the only one in this series that is a bit more complex.
Currently the drivers have a open-coded implementation of shared controls
which is replaced by the patch with the generic one from the ASoC core.
Unfortunately this changes the controls that are exposed by the driver,
instead of having a "Left HP Mixer ..." and a "Right HP Mixer ..." control
for each mixer input there will only be a single "HP Mixer" control. This
may or may not be considered breaking the userspace interface. If it is we
need to take a different approach at removing the virtual register form the
driver.

- Lars

Lars-Peter Clausen (14):
  ASoC: ad1980: Remove unused header
  ASoC: ad1980: Cleanup printk usage
  ASoC: ad1980: Use table based control setup
  ASoC: stac9766: Cleanup printk usage
  ASoC: stac9766: Use table based control setup
  ASoC: wm9705: Cleanup printk usage
  ASoC: wm9705: Use table based control setup
  ASoC: wm9712: Cleanup printk usage
  ASoC: wm9712: Use table based control setup
  ASoC: wm9713: Cleanup printk usage
  ASoC: wm9713: Use table based control setup
  ASoC: wm9713: Move driver state struct allocation to driver probe
  ASoC: wm9713: Use virtual control instead of virtual register
  ASoC: wm9712/wm9713: Use shared controls

 sound/soc/blackfin/bf5xx-ad1980.c |   2 -
 sound/soc/codecs/ad1980.c         |  23 ++----
 sound/soc/codecs/ad1980.h         |  26 ------
 sound/soc/codecs/stac9766.c       |   9 +-
 sound/soc/codecs/wm9705.c         |  14 ++--
 sound/soc/codecs/wm9712.c         | 136 +++++++-----------------------
 sound/soc/codecs/wm9713.c         | 170 +++++++++++---------------------------
 7 files changed, 98 insertions(+), 282 deletions(-)
 delete mode 100644 sound/soc/codecs/ad1980.h

-- 
1.8.0
