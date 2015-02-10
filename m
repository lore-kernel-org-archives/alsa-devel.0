From: Yakir Yang <ykk@rock-chips.com>
Subject: [RFC PATCH 0/1] Improve eye-diagram & single-ended
	test for rk3288 hdmi
Date: Tue, 10 Feb 2015 22:20:51 +0800
Message-ID: <1423578051-19425-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CB4126147D
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 15:21:31 +0100 (CET)
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, djkurtz@chromium.org, dianders@chromium.org, Yakir Yang <ykk@rock-chips.com>, mmind00@googlemail.com, Pawel Moll <pawel.moll@arm.com>, linux-rockchip@lists.infradead.org, Sean Cross <xobs@kosagi.com>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org, marcheu@chromium.org, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 25%-30% decrease.
- For hdmi single-ended test, we set CKLVL & TXLVL to 17 when pixel
  clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is 148.5MHz.


Yakir Yang (1):
  drm: bridge/dw_hdmi: fixed codec style

 drivers/gpu/drm/bridge/dw_hdmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.9.5
