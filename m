From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 4/6] ASoC: sgtl5000: Disable internal PLL early
Date: Tue, 14 Jun 2016 23:13:28 -0300
Message-ID: <CAOMZO5CP3-WdFWj5BbBuAYtzCATRx4mTx4gC9jjJQ66eduDpVw@mail.gmail.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com> <20160606231453.19377-5-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-5-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Eric Nelson <eric@nelint.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 8:14 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> From: Eric Nelson <eric@nelint.com>
>
> To handle the soft reboot case, the internal PLL must be
> disabled in SGTL5000_CHIP_CLK_CTRL before clearing bits
> SGTL5000_VCOAMP_POWERUP and SGTL5000_PLL_POWERUP in
> register SGTL5000_CHIP_ANA_POWER.
>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
