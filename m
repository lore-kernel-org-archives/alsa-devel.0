From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 13/16] ASoC: madera: Add common support for Cirrus Logic
 Madera codecs
Date: Mon, 10 Apr 2017 13:03:47 -0500
Message-ID: <20170410180347.y4sazqpxzcyn2je3@rob-hp-laptop>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-14-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491386884-30689-14-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.org, broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2017 at 11:08:01AM +0100, Richard Fitzgerald wrote:
> The Cirrus Logic Madera codecs are a family of related codecs with
> extensive digital and analogue I/O, digital mixing and routing,
> signal processing and programmable DSPs.
> 
> This patch adds common support code shared by all Madera codecs.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
> Signed-off-by: Ajit Pandey <ajit.pandey@incubesol.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/sound/madera.txt |   63 +
>  MAINTAINERS                                        |    5 +
>  include/dt-bindings/sound/madera.h                 |   18 +

Acked-by: Rob Herring <robh@kernel.org>

>  include/sound/madera-pdata.h                       |   70 +
>  sound/soc/codecs/Kconfig                           |    5 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/madera.c                          | 4430 ++++++++++++++++++++
>  sound/soc/codecs/madera.h                          |  470 +++
>  8 files changed, 5063 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/madera.txt
>  create mode 100644 include/dt-bindings/sound/madera.h
>  create mode 100644 include/sound/madera-pdata.h
>  create mode 100644 sound/soc/codecs/madera.c
>  create mode 100644 sound/soc/codecs/madera.h
