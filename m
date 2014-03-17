From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH v3 2/4] ASoC: simple-card: dynamically allocate
 the DAI link and properties
Date: Mon, 17 Mar 2014 12:27:16 +0200
Message-ID: <5326CE04.2090504@ti.com>
References: <cover.1394883134.git.moinejf@free.fr>	<1cf50fea2306bcb05987533042dbf1495b2c6f07.1394883134.git.moinejf@free.fr>	<5326C086.6080609@ti.com> <20140317112332.4a0700d8@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140317112332.4a0700d8@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/17/2014 12:23 PM, Jean-Francois Moine wrote:
> Jyri,
>
> No, this would not work. The DAI link in the struct snd_soc_card is an
> array of struct snd_soc_dai_link. There cannot be anything between the
> elements!

Oh.. did not go deep enough. Forget about this comment.

Best regards,
Jyri
