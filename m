From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH v2 3/4] ASoC: simple-card: accept many DAI
 links
Date: Fri, 14 Mar 2014 13:16:12 +0200
Message-ID: <5322E4FC.7060605@ti.com>
References: <cover.1394533640.git.moinejf@free.fr> <d71a2b62b331302772d35b3cd35c6dc5da1e9e5d.1394533640.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d71a2b62b331302772d35b3cd35c6dc5da1e9e5d.1394533640.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/11/2014 11:36 AM, Jean-Francois Moine wrote:
> Some simple audio cards may have many DAI links.
> This patch extends the simple-card driver for handling such cards.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
[...]

Why can't you just use two simple-card instances in your setup?

You need to update the DT-binding document too when you are changing the 
binding. That way it would also be easier to follow what you are trying 
to accomplish here.

The sysclk and tdm properties appear to only work in the dais of the 
first dai-link and __asoc_simple_card_dai_init() will not be called for 
other dais at all. The DT-binding of this implementation would look 
pretty hairy to me.

Best regards,
Jyri
