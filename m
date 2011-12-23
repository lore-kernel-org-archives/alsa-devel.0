From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 8/9] OMAP4: omap4panda: Enable audio support
Date: Fri, 23 Dec 2011 11:43:58 +0530
Message-ID: <CAMQu2gwO_opg9GVoE6CvH0xB7kQYSEofSkqzuONOVfuA9fZPbg@mail.gmail.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com> <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Anders <x0132446@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 1:04 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> PandaBoard has twl6040 codec for audio.
> Register the omap4-abe-twl6040 platform device.
> Add platform data to enable the twl6040 codec.
> Since there is a difference in audio between =A0PandaBoard 4430
> and PandaBoard ES (4460):
> Use different name for the sound card:
> "OMAP4-Panda" for PandaBoard 4430
> "OMAP4-PandaES" for PandaBoard ES
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: David Anders <x0132446@ti.com>
> ---
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
