From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 03/18] dt-bindings: mfd: Add bindings for Cirrus Logic
 Madera codecs
Date: Fri, 28 Apr 2017 13:07:31 -0500
Message-ID: <20170428180731.awgm5vnynaoaxeoe@rob-hp-laptop>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493050124-5970-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 05:08:29PM +0100, Richard Fitzgerald wrote:
> Specification of the bindings for the parent MFD driver component
> of the Cirrus Logic Madera codec drivers.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes since V1:
> - split out from main MFD patch
> - moved interrupt control binding descriptions into here
> - added description of the regulator child nodes
> - fixed the node name of the example
> - removed the MICBIAS from the example, these have been removed from the code
> 
>  Documentation/devicetree/bindings/mfd/madera.txt | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt

Acked-by: Rob Herring <robh@kernel.org>
