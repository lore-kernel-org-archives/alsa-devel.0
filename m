From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 13/18] dt-bindings: gpio: Add bindings for GPIO on
 Cirrus Logic Madera codecs
Date: Fri, 28 Apr 2017 13:17:23 -0500
Message-ID: <20170428181723.g6zs4ibb5ehvzico@rob-hp-laptop>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-14-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493050124-5970-14-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 05:08:39PM +0100, Richard Fitzgerald wrote:
> The Cirrus Logic Madera codecs have a range of GPIO pins that can be
> used as single-bit logic input or output. These are presented as a
> standard GPIO binding.
> 
> The second cell in a GPIO binding is currently reserved for future use
> as chip-specific flags.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes from V1:
> - moved out of main gpio patch into a separate patch
> - added gpio-line-names as an optional property
> 
>  .../devicetree/bindings/gpio/gpio-madera.txt       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-madera.txt

Acked-by: Rob Herring <robh@kernel.org>
