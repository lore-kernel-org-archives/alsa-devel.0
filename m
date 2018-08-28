From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
Date: Tue, 28 Aug 2018 10:57:43 +0300
Message-ID: <CAHp75Vd2B47bMHOuDtFcRUbbMXekgxsG+WP5kj-E1Z_K09=C4w@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-51-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-51-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, olivier.moysan@st.com, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 28, 2018 at 4:57 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
> +                (unsigned long long) res.start, dma_channel_np);

I understand that is not the part of the change, but wouldn't be good
to replace that ugly casting with proper specifier as well?
I mean
%pa ... &res.start

> +                       dev_err(&pdev->dev, "%pOFn sync own reference\n",
> +                               np);

One line?

-- 
With Best Regards,
Andy Shevchenko
