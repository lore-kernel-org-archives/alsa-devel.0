From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/22] ASoC: ab8500: Inform SoC Core that
 we have our own I/O arrangements
Date: Tue, 14 Aug 2012 10:40:46 +0200
Message-ID: <CACRpkdY9L_-RwV6xWV9ta+qubWce0ZH0+FXaCHkeaWRvSYUhKQ@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D372652A6
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 10:11:01 +0200 (CEST)
Received: by vcqp16 with SMTP id p16so97906vcq.38
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 01:40:46 -0700 (PDT)
In-Reply-To: <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
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

> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000080
> pgd = c0004000
> [00000080] *pgd=00000000
> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1    Not tainted  (3.5.0-rc6-00884-g0b2419e-dirty #130)
> PC is at regmap_read+0x10/0x5c
> LR is at hw_read+0x80/0x90
> pc : [<c01a91b8>]    lr : [<c0216804>]    psr: 60000013
>
> CC: alsa-devel@alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

No clue on this one, have to refer to Mark...

Linus Walleij
