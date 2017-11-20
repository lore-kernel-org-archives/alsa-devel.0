From: Rob Herring <robh@kernel.org>
Subject: Re: [v5 RESEND 07/17] regulator: arizona-micsupp: Add support for
 Cirrus Logic Madera codecs
Date: Mon, 20 Nov 2017 12:47:15 -0600
Message-ID: <20171120184715.odltgj6frwixcr4p@rob-hp-laptop>
References: <20171120141051.29467-1-rf@opensource.cirrus.com>
 <20171120141051.29467-8-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171120141051.29467-8-rf@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 20, 2017 at 02:10:41PM +0000, Richard Fitzgerald wrote:
> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> 
> This adds a new driver identity "madera-micsupp" and probe function
> so that this driver can be used to control the micsupp regulator on
> Cirrus Logic Madera codecs.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  .../bindings/regulator/arizona-regulator.txt       |  3 +-

Please add acks when posting a new version.

>  drivers/regulator/Kconfig                          |  7 ++-
>  drivers/regulator/arizona-micsupp.c                | 71 +++++++++++++++++++++-
>  3 files changed, 76 insertions(+), 5 deletions(-)
