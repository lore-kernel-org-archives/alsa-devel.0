From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] ASoC: ux500: Fix sparse non static
	symbol warning
Date: Wed, 8 Jan 2014 11:17:28 +0100
Message-ID: <CACRpkdYet_yzg0jhd4DiEyTMjL42FAb9DsYPWRv=AXVbz1Tvuw@mail.gmail.com>
References: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E3A2126501D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:17:29 +0100 (CET)
Received: by mail-oa0-f52.google.com with SMTP id o6so1511033oag.25
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 02:17:29 -0800 (PST)
In-Reply-To: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 8, 2014 at 11:13 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warning:
>
> sound/soc/ux500/ux500_msp_i2s.c:649:5: warning:
>  symbol 'ux500_msp_i2s_of_init_msp' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Lee, is this something that needs to go along with your patches to
ASoC or can I apply this separately?

Yours,
Linus Walleij
