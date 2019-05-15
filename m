From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/5] ASoC: meson: add hdmitx glue support
Date: Wed, 15 May 2019 11:33:17 -0700
Message-ID: <7h7eard0uq.fsf@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On the Amlogic SoC, there is a glue between the SoC audio outputs and the
> input of the embedded Synopsys HDMI controller.
>
> On the g12a, this glue is mostly a couple of muxes to select the i2s and
> spdif inputs of the hdmi controller. Each of these inputs may have
> different hw_params and fmt which makes our life a little bit more
> interesting, especially when switching between to active inputs.
>
> This glue is modeled as codec driver and uses codec-to-codec links to
> connect to the Synopsys controller. This allows to use the regular
> hdmi-codec driver (used by dw-hdmi i2s).
>
> To avoid glitches while switching input, the trick is to temporarily
> force a disconnection of the mux output, which shutdowns the output dai
> link. This also ensure that the stream parameters and fmt are updated
> when the output is connected back.

Tested-by: Kevin Hilman <khilman@baylibre.com>
