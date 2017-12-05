From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility
	with A64 codec I2S
Date: Tue, 5 Dec 2017 15:04:19 -0800
Message-ID: <CA+E=qVeZtWqLZddHtZMv264bWaVcReToYqkriYryf+wZnUVtCA@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
 <20171205080149.2siofhpynfrvnoiq@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 16405267842
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 00:04:40 +0100 (CET)
Received: by mail-oi0-f50.google.com with SMTP id x20so1360507oix.12
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 15:04:40 -0800 (PST)
In-Reply-To: <20171205080149.2siofhpynfrvnoiq@flea.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 5, 2017 at 12:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, Dec 03, 2017 at 11:34:06PM -0800, Vasily Khoruzhick wrote:
>> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
>> compatible with this one, but similar to H3.
>
> Please don't top-post.
>
> What are those differences?

Different registers and their locations. Compare quirks for
sun50i_a64_acodec_i2s and sun8i_h3_i2s fro details.

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
