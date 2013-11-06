From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/13] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
Date: Wed, 6 Nov 2013 12:50:29 +0100
Message-ID: <CACRpkdZtsoLk6VaxPCFY8jZdrmxM9Q2Mz60QJ6+H_XNzMqKVYg@mail.gmail.com>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-12-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A61B12616F4
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 12:50:30 +0100 (CET)
Received: by mail-oa0-f41.google.com with SMTP id m1so2041488oag.0
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2013 03:50:29 -0800 (PST)
In-Reply-To: <1383732985-18928-12-git-send-email-lee.jones@linaro.org>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In this patch we do two things. Firstly, instead of open coding the
> store of DMA data in to the DAI for later use, we use the API provided.
> Secondly we create and store similar DMA data for the DT case, only
> this time we use 'struct snd_dmaengine_dai_dma_data' which is provided
> by the core for this very reason.
>
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
