From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 03/17] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
Date: Wed, 13 Dec 2017 00:51:13 +0100
Message-ID: <CACRpkdahFBqzG_mU63NVZRKHH2VpWJYH6gGwKMiZaiTjFy=-UA@mail.gmail.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
 <fe8064a5-8692-46c1-9f53-ab0a429baeeb@EX17.ad.cirrus.com> <CACRpkdaxKjPd_k8tuO3R4+5LFT4_37zn6ruDRPd5j9xNAH4+Dw@mail.gmail.com>
 <1eff5a38-cff3-449b-bda4-047f50a9f1d4@EX17.ad.cirrus.com> <CACRpkdZ4QuOhk1LuGftcFozUKdZ4vFAO3omkQ004k39J=jKL7g@mail.gmail.com>
 <ce3772d8-3ae7-474f-b9c2-8008bb39fd0b@EX17.ad.cirrus.com> <CACRpkdb_i4k3F0fmDbQciPYTBUCcfpFkqM=5e3gr75-X51TTkg@mail.gmail.com>
 <e11d1657-0dfe-4de6-8928-0512ae3c1f1a@EX17.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <e11d1657-0dfe-4de6-8928-0512ae3c1f1a@EX17.ad.cirrus.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, alsa-devel@alsa-project.org, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, linux-gpio@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 7, 2017 at 11:52 AM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:
> On 07/12/17 08:54, Linus Walleij wrote:

>> If what you want is unconditional pin control enabled for this circuit,
>> then have MFD_MADERA select PINCTRL.

> So the short version of this email thread is that it should be "select
> PINCTRL" ?

If by "it" you mean MFD_MADERA tne  I guess yes :D

I was just confused because I couldn't figure out what you were
trying to do.

Yours,
Linus Walleij
