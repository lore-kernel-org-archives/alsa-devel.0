From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] ASoC/MFD: twl6040: Remove codec driver
	local reg cache
Date: Fri, 29 Nov 2013 16:03:42 +0200
Message-ID: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id AA673261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 15:03:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

It was not straight forward task to remove the local reg cache from the twl6040
codec driver. I also needed to change the MFD part so it will take over the
caching of registers via regmap.
So far I have the following patches working on top of mainline kernel.

Is this close enough of what you had in mind when asked me to look at this?

twl4030 codec is going to be a bit more complicated AFAIK but it will come
eventually.

Regards,
Peter
---
Peter Ujfalusi (5):
  ASoC: twl6040: Rename twl6040_is_path_unmuted ->
    twl6040_can_write_to_chip
  ASoC: twl6040: Custom caching for sensitive DL1/2 path registers
  MFD: twl6040: reg_defaults support for regmap
  ASoC: twl6040: Remove register restore functionality
  ASoC: twl6040: Remove self managed local reg_cache support

 drivers/mfd/twl6040.c      |  92 +++++++++++++++++-
 sound/soc/codecs/twl6040.c | 227 +++++++++++++--------------------------------
 2 files changed, 155 insertions(+), 164 deletions(-)

-- 
1.8.4.2
