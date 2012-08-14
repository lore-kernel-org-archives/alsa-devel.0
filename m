From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/22] ASoC: Ux500: Enable MOP500 driver
	for Device Tree
Date: Tue, 14 Aug 2012 10:52:23 +0200
Message-ID: <CACRpkdZ+zgEf48qpCRg_fz9=_oSGohuSsFLQoC3BzTgSDdNnZA@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EE892652AC
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 10:22:38 +0200 (CEST)
Received: by vcqp16 with SMTP id p16so104719vcq.38
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 01:52:24 -0700 (PDT)
In-Reply-To: <1344527268-5964-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we ensure that the MOP500 audio driver will be probed during a
> Device Tree boot. We also parse the sound node to link together the
> codec, dma and the CPU-side Digital Audio Interface.
>
> CC: alsa-devel@alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

But only if Mark agrees with the overall approach.

Yours,
Linus Walleij
