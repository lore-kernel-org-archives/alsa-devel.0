From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Date: Mon, 1 Jan 2018 16:17:20 +0100
Message-ID: <b8e41d81-948a-fbac-af75-3e31c3382426@maciej.szmigiero.name>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 19.12.2017 18:00, Nicolin Chen wrote:
> AC97 configures some registers earlier to start a communication
> with CODECs, so this patch moves those register settings to the
> dai_probe() as well, along with other register configurations.
> 
> It also applies _fsl_ssi_set_dai_fmt() to AC97 only since other
> formats would be configured via fsl_ssi_set_dai_fmt() directly.
> 
> Meanwhile, this patch adds fsl_ssi_dai_ac97_remove() to cleanup
> some control bits for AC97.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

This patch breaks AC'97 CODEC probing.

Namely, the fsl_ssi DAI probe callback is only called after the AC'97
CODEC probe callback, so when you move SSI AC'97 startup to its DAI
probe callback it won't be done yet when the CODEC is probed (and this
requires a working AC'97 interface to successfully complete).

Maciej
