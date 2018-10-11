From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] pinctrl: madera: Fix uninitialized variable bug in madera_mux_set_mux
Date: Thu, 11 Oct 2018 10:40:08 +0200
Message-ID: <CACRpkda8Fo6ubO9XuDXC9tcLWPNp_6TMf6-g9DUxdU6JXa0Veg@mail.gmail.com>
References: <20181010151313.GA16854@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010151313.GA16854@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 10, 2018 at 5:13 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> There is a potential execution path in which variable *ret* is checked
> in an IF statement, and then its value is used to report an error at
> line 659 without being properly initialized previously:
>
> 659 if (ret)
> 660     dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
>
> Fix this by initializing variable *ret* to 0 in order to
> avoid unpredictable or unintended results.
>
> Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
> Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Initialize variable ret to 0 instead of -1. Thanks to Charles Keepax
>    for pointing this out.
>  - Update subject and commit log.

Patch applied with Charles' ACK.

Yours,
Linus Walleij
