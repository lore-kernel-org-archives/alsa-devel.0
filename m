From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] ASoC: ux500: Fix sparse non static
	symbol warning
Date: Wed, 8 Jan 2014 12:58:06 +0100
Message-ID: <CACRpkdbq5zWX2o9tOhxMastRChEigvkSRVoz+7UEvF9AOaBUHQ@mail.gmail.com>
References: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
 <CACRpkdYet_yzg0jhd4DiEyTMjL42FAb9DsYPWRv=AXVbz1Tvuw@mail.gmail.com>
 <20140108110603.GG19974@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE1C261A1F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 12:58:07 +0100 (CET)
Received: by mail-oa0-f45.google.com with SMTP id g12so1677919oah.32
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 03:58:06 -0800 (PST)
In-Reply-To: <20140108110603.GG19974@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wei Yongjun <weiyj.lk@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 8, 2014 at 12:06 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 08 Jan 2014, Linus Walleij wrote:
>
>> On Wed, Jan 8, 2014 at 11:13 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> >
>> > Fixes the following sparse warning:
>> >
>> > sound/soc/ux500/ux500_msp_i2s.c:649:5: warning:
>> >  symbol 'ux500_msp_i2s_of_init_msp' was not declared. Should it be static?
>> >
>> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> FWIW: Acked-by: Lee Jones <lee.jones@linaro.org>
>
>> Lee, is this something that needs to go along with your patches to
>> ASoC or can I apply this separately?
>
> If Mark takes it, then it will just apply as my patches have already
> been applied.

Mark can you take this patch to minimize the fuzz?

Yours,
Linus Walleij
