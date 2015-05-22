From: Yakir Yang <ykk@rock-chips.com>
Subject: [RESEND PATCH v1 0/2] Add dw_hdmi i2s audio driver
	support
Date: Fri, 22 May 2015 10:13:51 -0500
Message-ID: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4C3265D8A
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 17:14:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Dave Airlie <airlied@redhat.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Yan <andy.yan@rock-chips.com>, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>
List-Id: alsa-devel@alsa-project.org


As Russell have send an series patches for dw_hdmi audio, it make us
upload dw_hdmi audio patch more easier, and most important it works
well on rockchip platform, so I make this patch that try to add another
audio interface support in dw_hdmi driver.

Here are the list that I have make in my series:
- rename dw_hdmi-ahb-audio.h to dw_hdmi-audio.h
- add dw_hdmi i2s audio driver

Here are the series patches that I depends on:
* drm: bridge/dw_hdmi: fixed codec style [Yakir Yang]
* drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
* drm: bridge/dw_hdmi: improve hdmi single-end test
* drm: imx/dw_hdmi: move phy comments [Russell King]
* drm: bridge/dw_hdmi: clean up phy configuration
* drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
* drm: bridge/dw_hdmi: protect n/cts setting with a mutex
* drm: bridge/dw_hdmi: adjust n/cts setting order
* drm: bridge/dw_hdmi: clean up hdmi_set_clk_regenerator()
* drm: bridge/dw_hdmi: use drm_hdmi_avi_infoframe_from_display_mode()
* drm: bridge/dw_hdmi: simplify hdmi_config_AVI() a little
* drm: bridge/dw_hdmi: remove mhsyncpolarity/mvsyncpolarity/minterlaced
* drm: bridge/dw_hdmi: introduce interface to setting sample rate
* drm: bridge/dw_hdmi: introduce interfaces to enable and disable audio
* drm/edid: add function to help find SADs
* sound/core: add DRM ELD helper
* sound/core: add IEC958 channel status helper
* drm: bridge/dw_hdmi-ahb-audio: add audio driver
* drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI driver

Best regards,
Yakir Yang



Yakir Yang (2):
  drm: bridge/dw_hdmi: rename dw_hdmi-ahb-audio.h to dw_hdmi-audio.h
  drm: bridge/dw_hdmi-i2s-audio: add audio driver

 drivers/gpu/drm/bridge/Kconfig                     |   9 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c         |   2 +-
 .../{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h}       |   0
 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c         | 412 +++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi.c                   |  26 +-
 drivers/gpu/drm/bridge/dw_hdmi.h                   |   3 +
 7 files changed, 442 insertions(+), 11 deletions(-)
 rename drivers/gpu/drm/bridge/{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h} (100%)
 create mode 100644 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c

-- 
2.1.2
