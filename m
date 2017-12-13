From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v10 00/13] Introduce framework for SLIMbus device driver
Date: Wed, 13 Dec 2017 10:25:02 +0100
Message-ID: <20171213092502.GA12631@kroah.com>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171211234307.14465-1-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, pombredanne-od1rfyK75/E@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 11:42:54PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
> channels, and control channel. Control channel has messages to do
> device-enumeration, messages to send/receive control-data to/from
> SLIMbus devices, messages for port/channel management, and messages to
> do bandwidth allocation.
> Framework is introduced to support  multiple instances of the bus
> (1 controller per bus), and multiple slave devices per controller.
> SPI and I2C frameworks, and comments from last time when I submitted
> the patches were referred-to while working on this framework.
> 
> These patchsets introduce device-management, OF helpers, and messaging
> APIs, controller driver for Qualcomm's SLIMbus controller, and
> clock-pause feature for entering/exiting low-power mode for SLIMbus.
> Framework patches to do channel, port and bandwidth
> management are work-in-progress and will be sent out once these
> initial patches are accepted.
> 
> These patchsets were tested on IFC6410 board with Qualcomm APQ8064
> processor using the controller driver, and a WCD9310 codec.
> 
> v9: https://lkml.org/lkml/2017/12/7/289
> 
> Changes from v9 to v10:
> * Added kernel-doc reference into slimbus driver api doc suggested by
>  Jonathan Corbet

These all look good to me.  I can take this through my tree if I get the
ack from Mark for the regmap changes.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
