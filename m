From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/16] pinctrl: madera: Add driver for
 Cirrus Logic Madera codecs
Date: Mon, 10 Apr 2017 12:56:58 -0500
Message-ID: <20170410175658.a64tmev7hxzon2el@rob-hp-laptop>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-10-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 257CD266BA4
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 19:57:00 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id o83so888869oik.1
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 10:57:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491386884-30689-10-git-send-email-rf@opensource.wolfsonmicro.com>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2017 at 11:07:57AM +0100, Richard Fitzgerald wrote:
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
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  103 ++

As Linus said, separate patch is preferred. But I don't have any other 
comments, so I'm not going to require it:

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |    2 +
>  drivers/pinctrl/Kconfig                            |   22 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-madera.c                   | 1092 ++++++++++++++++++++
>  5 files changed, 1220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-madera.c
