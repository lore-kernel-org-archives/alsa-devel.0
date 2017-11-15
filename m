From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] media: i2c: Add TDA1997x HDMI receiver
	driver
Date: Wed, 15 Nov 2017 09:52:04 -0600
Message-ID: <20171115155204.yhqjocdm32qunllx@rob-hp-laptop>
References: <1510253136-14153-1-git-send-email-tharvey@gateworks.com>
 <1510253136-14153-4-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f181.google.com (mail-ot0-f181.google.com
 [74.125.82.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B95F9266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 16:52:06 +0100 (CET)
Received: by mail-ot0-f181.google.com with SMTP id g104so7864803otg.7
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 07:52:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1510253136-14153-4-git-send-email-tharvey@gateworks.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, shawnguo@kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 09, 2017 at 10:45:34AM -0800, Tim Harvey wrote:
> Add support for the TDA1997x HDMI receivers.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3:
>  - use V4L2_DV_BT_FRAME_WIDTH/HEIGHT macros
>  - fixed missing break
>  - use only hdmi_infoframe_log for infoframe logging
>  - simplify tda1997x_s_stream error handling
>  - add delayed work proc to handle hotplug enable/disable
>  - fix set_edid (disable HPD before writing, enable after)
>  - remove enabling edid by default
>  - initialize timings
>  - take quant range into account in colorspace conversion
>  - remove vendor/product tracking (we provide this in log_status via infoframes)
>  - add v4l_controls
>  - add more detail to log_status
>  - calculate vhref generator timings
>  - timing detection fixes (rounding errors, hswidth errors)
>  - rename configure_input/configure_conv functions
> 
> v2:
>  - implement dv timings enum/cap
>  - remove deprecated g_mbus_config op
>  - fix dv_query_timings
>  - add EDID get/set handling
>  - remove max-pixel-rate support
>  - add audio codec DAI support
>  - change audio bindings
> ---
>  drivers/media/i2c/Kconfig            |    9 +
>  drivers/media/i2c/Makefile           |    1 +
>  drivers/media/i2c/tda1997x.c         | 3485 ++++++++++++++++++++++++++++++++++
>  include/dt-bindings/media/tda1997x.h |   78 +

This belongs with the binding documentation patch.

>  include/media/i2c/tda1997x.h         |   53 +
>  5 files changed, 3626 insertions(+)
>  create mode 100644 drivers/media/i2c/tda1997x.c
>  create mode 100644 include/dt-bindings/media/tda1997x.h
>  create mode 100644 include/media/i2c/tda1997x.h
