From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 13/18] dt-bindings: gpio: Add bindings
 for GPIO on Cirrus Logic Madera codecs
Date: Tue, 25 Apr 2017 11:42:52 +0200
Message-ID: <CACRpkdYnvfDfuyr6Jha7zFQbU9dRN8BqpgHUvGe4fyxeMgKSeQ@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-14-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B12F9266F35
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 11:42:54 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id k87so212983268ioi.0
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 02:42:54 -0700 (PDT)
In-Reply-To: <1493050124-5970-14-git-send-email-rf@opensource.wolfsonmicro.com>
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
