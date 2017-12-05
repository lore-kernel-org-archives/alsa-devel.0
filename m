From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
Date: Tue, 5 Dec 2017 15:17:39 -0800
Message-ID: <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171205080444.zo2rlusqpjyraqcw@flea.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 5, 2017 at 12:04 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
>> Digital part of audio codec block in the A64 is very similar to what
>> is used by the A33(sun8i) devices. However, it uses different LRCK
>> divider.
>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> What makes it impossible to derive from the sample rate and number of
> channels?

It's BCLK / LRCK ratio as per A64 user manual, so it doesn't depend on
sample rate. BSP driver always uses a fixed value of 64 here.

> Have you tried other sampling rates?

I tried speaker-test with a number of sampling rates and had no
issues. I couldn't try it in mono, since sun4i-i2s supports minimum of
2 channels.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
