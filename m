From: chen liu <chen.liu.opensource@gmail.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Fri, 15 Dec 2017 21:07:15 +0800
Message-ID: <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D6BEA267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 14:07:17 +0100 (CET)
Received: by mail-vk0-f45.google.com with SMTP id m15so5525274vkf.13
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 05:07:17 -0800 (PST)
In-Reply-To: <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

2017-12-15 0:19 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:

> On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
>
> OK so looking over this some more with Mark's comments in mind
> the thing that troubles me is this. Currently there are two ways
> you can configure the clocking manually or automatically.
>
> The manual way using the set_dai_pll, set_dai_clkdiv and
> set_dai_sysclk calls.
>
> Automatically by calling set_dai_sysclk and set_dai_pll with
> WM8960_SYSCLK_AUTO and the driver will work it out for you. This
> option already supports setting the SYSCLK_DIV.
>
> I guess my first question would be can you get the result you
> desire by just using the automatic option?
>
> If not, it seems like what we are trying to do here is move the
> set_dai_clkdiv for SYSCLK_DIV to be automatic in both cases. The
> problem is that I suspect this handling interfers somewhat with the
> handling of these bits that is done in wm8960_configure_clocking
> through wm8960_configure_pll when we are doing things
> automatically. In which case I think you need to look at how to
> align these two clocking methods.
>

Hi Charles,

When the MCLK clock frequency cannot meet the SYSCLK clock
frequency of the wm8960 codec,we must use the PLL divider to
generate the clock frequency.

For what you are talking about setting the SYSCLK clock frequency
automatically and manually,the difference is that one uses the PLL
divider to generate the SYSCLK clock frequency and the other one
provides the SYSCLK clock frequency directly through the MCLK.

Although the driver already supports setting the SYSCLK_DIV register,
it can only be set to 1,thus causing the codec to not support multiple
MCLK clock frequency.(For more information, please see the wm8960
codec manual)

The important purpose of this patch is to support multiple MCLK
clock frequency.

Thanks again,
Chen.
