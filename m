From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 12/18] gpio: madera: Support Cirrus
	Logic Madera class codecs
Date: Fri, 28 Apr 2017 09:44:22 +0200
Message-ID: <CACRpkdYBSaGzV7hzw+SJ+Oj-hdoFj7z0KiUrMnbnHZPEq0hNmA@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB4026680F
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 09:44:24 +0200 (CEST)
Received: by mail-it0-f46.google.com with SMTP id g66so31732662ite.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 00:44:24 -0700 (PDT)
In-Reply-To: <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
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

> This adds support for the GPIOs on Cirrus Logic Madera class codecs.
> Any pins not used for special functions (see the pinctrl driver) can be
> used as general single-bit input or output lines. The number of available
> GPIOs varies between codecs.
>
> Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> Changes from V1:
> - dt bindings moved to a separate patch
> - dependent on pinctrl driver instead of parent MFD
> - added get_direction function
> - added .request / .free / .set_config to work with pinctrl driver
> - register range with pinctrl driver

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
