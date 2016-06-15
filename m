From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 5/6] ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF
Date: Tue, 14 Jun 2016 23:13:47 -0300
Message-ID: <CAOMZO5DezRjbds5W1EaPrk9TnVTrKVLebn9zZV+_H8=0o-iixg@mail.gmail.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com> <20160606231453.19377-6-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-6-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Eric Nelson <eric@nelint.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 8:14 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> From: Eric Nelson <eric@nelint.com>
>
> Disabling the SGTL5000 through regulators would certainly save more
> power than simply disabling the reference voltages as described in the
> data sheet, but won't properly restore things on resume.
>
> This driver does not support active regulators. So we simply disable the
> reference bias currents.
>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
