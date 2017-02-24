From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 0/4] ASoC: es828: various improvements
Date: Fri, 24 Feb 2017 17:01:00 +0100
Message-ID: <20170224160104.29354-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A2D266834
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 17:01:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

This set of patches fixes clock handling in slave mode, enables
sampling frequency of 192khz in slave mode and adds support
for this frame rate in the driver rk3288_hdmi_analog.c.

Romain Perier (4):
  ASoC: es8328: Simplify rates definition
  ASoC: es8328: Let device auto detect ratios in slave mode
  ASoC: es8328: Enabling support for 192k
  ASoC: rockchip: Enable 192khz in hw_params operation

 sound/soc/codecs/es8328.c               | 51 +++++++++++++++++++--------------
 sound/soc/rockchip/rk3288_hdmi_analog.c |  3 ++
 2 files changed, 32 insertions(+), 22 deletions(-)

-- 
2.9.3
