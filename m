From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 08/13] regmap: add SLIMbus support
Date: Wed, 13 Dec 2017 10:25:37 +0100
Message-ID: <20171213092537.GB12631@kroah.com>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, pombredanne@nexb.com, j.neuschaefer@gmx.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 11:43:02PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to read/write SLIMbus value elements.
> Currently it only supports byte read/write. Adding this support in
> regmap would give codec drivers more flexibility when there are more
> than 2 control interfaces like SLIMbus, i2c.
> 
> Without this patch each codec driver has to directly call SLIMbus value
> element apis, and this could would get messy once we want to add i2c
> interface to it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/base/regmap/Kconfig          |  4 ++
>  drivers/base/regmap/Makefile         |  1 +
>  drivers/base/regmap/regmap-slimbus.c | 80 ++++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h               | 18 ++++++++
>  4 files changed, 103 insertions(+)
>  create mode 100644 drivers/base/regmap/regmap-slimbus.c

Mark, can I get an Ack for this patch so I can take it through my tree
with the other patches in this series?

thanks,

greg k-h
