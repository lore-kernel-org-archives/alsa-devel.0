From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup
	into the MSP driver
Date: Mon, 27 Aug 2012 16:09:46 -0700
Message-ID: <CACRpkdZse9Nq1acoAujV8ojhRKxykNX0ymcr51QAoanUbDW14g@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
 <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
 <20120820115914.GP8450@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B0D43265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 01:09:46 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so2900317wgb.20
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 16:09:46 -0700 (PDT)
In-Reply-To: <20120820115914.GP8450@gmail.com>
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
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Patrice CHOTARD <patrice.chotard@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 20, 2012 at 4:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, Aug 14, 2012 at 10:51:02AM +0200, Linus Walleij wrote:

>> But wait. These are just local statics. Surelty you can put these into
>> struct ux500_msp instead? Here it looks like these will be used for
>> all ports, so MSP2 will enable the pins requested by MSP1 etc
>> completely broken. So put it into the struct ux500_msp state
>> container from ux500_msp_i2s.h where it belongs.
>>
>> Refer to drivers/tty/serial/amba-pl011.c when in trouble. This
>> one is a good pinctrl example.
>
> How do you see the MSP1 and MSP3 usage protection working if I hide it
> all away in MSP specific structs?

Usage protection? Sorry not following. Please elaborate...

Yours,
Linus Walleij
