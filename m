From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/17] ASoC: Ux500: Move MSP pinctrl setup
	into the MSP driver
Date: Thu, 30 Aug 2012 16:46:17 -0700
Message-ID: <CACRpkdai+RObHsq7xe0+Fk24K7r-Wzoc8o3RbvHT78=EeHkjSQ@mail.gmail.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 271242661CA
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 01:46:18 +0200 (CEST)
Received: by wibhm2 with SMTP id hm2so766186wib.2
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 16:46:17 -0700 (PDT)
In-Reply-To: <1345816913-4113-2-git-send-email-lee.jones@linaro.org>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, roger.xr.nilsson@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 24, 2012 at 7:01 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In the initial submission of the MSP driver msp1 and msp3's associated
> pinctrl mechanism was passed back to platform code using a plat_init()
> call-back routine, but it has no place in platform code. The MSP driver
> should set this up for the appropriate ports. Instead we use a use_pinctrl
> identifier which is passed from platform_data/Device Tree which indicates
> which ports should use pinctrl.
>
> CC: alsa-devel@alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me, so Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the ux500 mach part.

However I'd request Ola/Roger to ACK it too on the ALSA side.

Yours,
Linus Walleij
