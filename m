From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: ux500: Drop pinctrl sleep support
Date: Fri, 24 May 2013 13:11:09 +0200
Message-ID: <CACRpkdbbi9u80RX+VHv+d3o3M+MfUZkR7thxFfqT62LeNq_AnA@mail.gmail.com>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
 <1369391960-27320-2-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C616265141
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 13:11:10 +0200 (CEST)
Received: by mail-ie0-f172.google.com with SMTP id 16so11739739iea.17
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 04:11:10 -0700 (PDT)
In-Reply-To: <1369391960-27320-2-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 24, 2013 at 12:39 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Drop pinctrl default/sleep state switching code, as it was breaking the
> capture interface by putting the I2S pins in hi-z mode regardless of its
> usage status, and not giving any real benefit.
>
> Pinctrl default mode configuration is already managed automatically by a
> specific pinctrl hog.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
