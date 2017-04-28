From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 10/18] pinctrl: madera: Add driver for
 Cirrus Logic Madera codecs
Date: Fri, 28 Apr 2017 09:39:21 +0200
Message-ID: <CACRpkdZPoZ0VK=UYsa=T7A_LXHZnULv+yKKFXCEomG+eozkfPQ@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 94B6326680F
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 09:39:24 +0200 (CEST)
Received: by mail-io0-f176.google.com with SMTP id r16so53074662ioi.2
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 00:39:24 -0700 (PDT)
In-Reply-To: <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> These codecs have a variable number of I/O lines each of which
> is individually selectable to a wide range of possible functions.
>
> The functionality is slightly different from the traditional muxed
> GPIO since most of the functions can be mapped to any pin (and even
> the same function to multiple pins). Most pins have a dedicated
> "alternate" function that is only available on that pin. The
> alternate functions are usually a group of signals, though it is
> not always necessary to enable the full group, depending on the
> alternate function and how it is to be used. The mapping between
> alternate functions and GPIO pins varies between codecs depending
> on the number of alternate functions and available pins.
>
> Note on the Kconfig options:
> The formula "default y if..." is used for PINCTRL_MADERA so that its
> select options will be processed, allowing us to group selects for
> pinctrl into the pinctrl Kconfig where they logically belong instead
> of accumulating under the parent MFD Kconfig.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes since V1:
> - dt binding moved to separate patch
> - moved all source into a subdirectory drivers/pinctrl/cirrus
> - split chip-specific tables into separate files
> - codec-specific build options are now selected from MFD
> - print useful information from madera_pin_dbg_show()
> - added gpio_set_direciton / gpio_request_enable / gpio_disable_free functions
> - added strict mode so GPIO and other functions are exclusive
> - replace #ifdefs with if (IS_ENABLED(...)) in probe
> - fixed bug reading registers in madera_pin_conf_get()

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will apply this through MFD, so waiting for Lee to
pick it up. Alternatively I can apply it after the MFD core parts
are upstream.

Yours,
Linus Walleij
