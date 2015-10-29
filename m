From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
Date: Thu, 29 Oct 2015 15:29:45 +0100
Message-ID: <CACRpkdav70DfCdLTfip+mOp=f9MVh8ORX_KVWQHGo3R3gYuA9A@mail.gmail.com>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
	<1445264027-7357-3-git-send-email-rf@opensource.wolfsonmicro.com>
	<CACRpkdZMsUbhvKiAEcKuEy7OCGLYG9Up_AUJcfThbVcMdPeLPg@mail.gmail.com>
	<20151028114205.GU5828@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028114205.GU5828@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 12:42 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 27 Oct 2015, Linus Walleij wrote:
>
>> On Mon, Oct 19, 2015 at 4:13 PM, Richard Fitzgerald
>> <rf@opensource.wolfsonmicro.com> wrote:
>>
>> > The CS47L24 and WM1831 codecs only have two GPIO lines, but are
>> > otherwise similar to the WM8280.
>> >
>> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Lee can merge this into the MFD tree with patch 1/3 if he likes,
>> I guess that's simplest.
>
> I can do.  Do you require a pull-request?

Nah. I usually optimistically assume that these (small) things will
not clash.

Yours,
Linus Walleij
