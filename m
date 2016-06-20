From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6] ASoC: rockchip: Add machine driver for
 RK3399 GRU Boards
Date: Mon, 20 Jun 2016 08:08:12 -0500
Message-ID: <20160620130812.GA24614@rob-hp-laptop>
References: <1466080858-29565-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f196.google.com (mail-ob0-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F852650F2
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 15:08:15 +0200 (CEST)
Received: by mail-ob0-f196.google.com with SMTP id wj2so4456681obc.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 06:08:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466080858-29565-1-git-send-email-zhengxing@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, smbarber@google.com, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2016 at 08:40:58PM +0800, Xing Zheng wrote:
> Because we need to support the multiple codecs (MAX98357A/RT5514/DA7219)
> on the RK3399 GRU boards, this patch can help us to support these codecs.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v6:
> - remove enable/disable dapm pins, and to switch codecs via user space
> - fix "Speaker" dapm route for max98357a
> - add SND_JACK_LINEOUT flag for da7219 jack detection
> 
> Changes in v5:
> - fix the build warning for missing I2C/CLKDEV_LOOKUP dependency
> 
> Changes in v4:
> - the compatible name needs to be based on a single reference design,
>   and the name of the board is called "GRU"
> - use one i2sX card "rockchip,cpu = <&i2s0>" instead of array that is
>   based on GRU
> - rename DOC to rockchip,rk3399-gru-sound.txt
> - rename compatible to rockchip,rk3399-gru-sound
> - rename source code to rk3399_gru_sound.c
> 
> Changes in v3:
> - rename DOC to rockchip,rk3399-max98357a-rt5514-da7219.txt
> - rename compatible to rockchip,rk3399-max98357a-rt5514-da7219
> - rename source code to rk3399_max98357a_rt5514_da7219.c
> 
> Changes in v2:
> - use the FS 256 to set mclks of the max98357a and rt5514 danamically
> - add more sample rate for da7219
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   15 +

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/rockchip/Kconfig                         |   11 +
>  sound/soc/rockchip/Makefile                        |    2 +
>  sound/soc/rockchip/rk3399_gru_sound.c              |  322 ++++++++++++++++++++
>  4 files changed, 350 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
>  create mode 100644 sound/soc/rockchip/rk3399_gru_sound.c
