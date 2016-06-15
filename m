From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/6] ASoC: sgtl5000: Write all default registers
Date: Tue, 14 Jun 2016 23:12:38 -0300
Message-ID: <CAOMZO5DAB-k29_rR32hYOiFmSMt2gJ8cCYUuhrJpm9pPgE9=YQ@mail.gmail.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com> <20160606231453.19377-3-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-3-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Eric Nelson <eric@nelint.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 8:14 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> From: Eric Nelson <eric@nelint.com>
>
> If an error occurs writing defaults, produce an error message but
> continue writing other registers. The failure of a single write should
> not cause catastrophic device failure.
>
> In at least one occurrence, I2C writes of CHIP_ANA_POWER were nacked,
> though continuing allowed the device to operate properly.
>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
