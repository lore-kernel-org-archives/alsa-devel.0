From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG] On Allwinner A20 Board Cubietruck distorted
 SPDIF opical output
Date: Wed, 23 May 2018 17:12:14 +0200
Message-ID: <CAEKpxBmDhEerr4CLAZEHGvj1eEce+yBV+fMUK6n6dDeOSLR+4A@mail.gmail.com>
References: <CAJnOVskuR6WG5tBVNT30t+k3y4hPR6VnQ=p_QQdBe3fuTWEf_Q@mail.gmail.com>
 <CAEKpxB=0ahGP=bnFAKDZatLLphADMig4P2Bkpkao-jzE9ORkEg@mail.gmail.com>
 <CAJnOVskcERpto7ztKcCDWKG9NMcgSjcM867bCgkcxG86sZ2MFw@mail.gmail.com>
 <CAJnOVs=kK+nPOHfWzAU0q1Nzu7XLwY6HojaZLHXeW1n71YG2wg@mail.gmail.com>
 <20180521131719.eyrmikexh7jsjrnu@flea> <CAJnOVske_kAmib1eKhkJJouYZE_1M4uwM-VVuBfThHvwVRmMrQ@mail.gmail.com>
 <CAEKpxB=pLzAH0-c4VCUYAa6EbvswfGGz3nxGez5fj6_hJ8mKQg@mail.gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBUEJS3MAKGQEH66T3PY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAEKpxB=pLzAH0-c4VCUYAa6EbvswfGGz3nxGez5fj6_hJ8mKQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Markus Mitsch <markusmitsch86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi All,
I can see that the problem was introduced somewhere here

DOESN'T WORK
ffc3eb6f3a83 Merge tag 'sunxi-clk-for-4.15' of
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
clk-next
ae74ac082886 Merge tag 'clk-v4.15-exynos-pm' of
git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into
clk-next
faa865f18cb7 Merge tag 'clk-v4.15-samsung' of
git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into
clk-next
f09a6b86fdae Merge tag 'clk-renesas-for-v4.15-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into clk-next
4328a2186e51 clk: sunxi-ng: sun4i: Export video PLLs
553c7d5ba2fe clk: sunxi-ng: Add A83T display clocks
7679eb20353d clk: samsung: Add a separate driver for Exynos4412 ISP clocks
8ca8ac102484 clk: samsung: Add dt bindings for Exynos4412 ISP clock controller
75920aac275a clk: samsung: Instantiate Exynos4412 ISP clocks only when available
24ea78a09f89 clk: sunxi-ng: sun8i: a23: Use sigma-delta modulation for audio PLL
ee6501d69217 clk: sunxi-ng: sun6i: Use sigma-delta modulation for audio PLL
042f7f8f9715 clk: sunxi-ng: sun5i: Use sigma-delta modulation for audio PLL
de3448519194 clk: sunxi-ng: sun4i: Use sigma-delta modulation for audio PLL
a5e3e2b2ef85 clk: sunxi-ng: sun8i: h3: Use sigma-delta modulation for audio PLL
392ba5fafcdf clk: sunxi-ng: nm: Add support for sigma-delta modulation
05d2eaac96d4 clk: sunxi-ng: Add sigma-delta modulation support
4cdbc40d64d4 clk: sunxi-ng: nm: Check if requested rate is supported
by fractional clock
d51fe3ba9773 clk: sunxi-ng: sun5i: Fix bit offset of audio PLL post-divider
4e8975cbb516 clk: samsung: exynos5433: mark PM functions as __maybe_unused
a4f21e9ceb5c clk: samsung: Remove obsolete clkdev alias support
45d882daf88a clk: samsung: Add explicit MPLL, EPLL clkdev aliases in
S3C2443 driver
cd05417f728b clk: samsung: Rework clkdev alias handling in S3C2443 driver
efea8d377184 clk: samsung: Rework clkdev alias handling in Exynos5440 driver
36ba48240b19 clk: samsung: Drop useless alias in Exynos5420 clk driver
29964890f31c clk: samsung: Remove clkdev alias support in Exynos5250 clk driver
6de08891c896 clk: samsung: Remove double assignment of CLK_ARM_CLK in
Exynos4 driver
58f4a5ff3a62 clk: samsung: Remove clkdev alias support in Exynos4 clk driver
c9194fb623b0 clk: samsung: Remove support for obsolete Exynos4212 CPU clock
d5cd103b06f9 clk: samsung: Remove support for Exynos4212 SoCs in
Exynos CLKOUT driver
7c4f63ec94a1 clk: sunxi-ng: a83t: Fix invalid csi-mclk mux offset
WORKS
0a4e632b6f9d Merge branch 'clk-fixes' into clk-next

BR,
CK


On 22 May 2018 at 21:27, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Markus,
> I've been able to reproduce this on my A31 board with linux-next(plays
> at 44100 but not at 96K)so it is an issue. I also tested the same code
> on my A64 and it worked fine, The blocks are very similar so it maybe
> a clocking issue, I'll look into this.
> BR,
> CK
>
> On 21 May 2018 at 20:17, Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> 2018-05-21 15:17 GMT+02:00 Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>:
>>> On Mon, May 21, 2018 at 02:43:55PM +0200, Markus Mitsch wrote:
>>>> 2018-05-21 11:43 GMT+02:00 Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>:
>>>> >>> Hello,
>>>> >>>
>>>> >>> i have a new problem. if i want to output sound from optical i get
>>>> >>> distorted sound. At 44.1 khz its like an old vinly, but at 48 khz and
>>>> >>> higher it is very bad. thanks in advance for your time.
>>>> >
>>>> >> Hi Markus,
>>>> >> I haven't tested it for a while but when I did it worked as high as
>>>> >> 96K with no issues. Does it work ok with the original cubietruck
>>>> >> software?,
>>>> >> CK
>>>> >
>>>> > Hello,
>>>> > i am using arch linux with mainline kernel 4.16.8. parhaps i can try
>>>> > today with official image.
>>>> > mfg
>>>>
>>>> Hi.
>>>> So, with debian image from 2014 with 3.4.79 kernel the sound is clear
>>>> up to 96 khz.
>>>
>>> You said that it is a new problem, when was it introduced? Could you
>>> bisect the issue?
>>>
>>> Maxime
>>
>> Hello.
>> I dont know since when this problem appears. When saying "new" i
>> refered to my older post. I tried to look into the dts file and the
>> code
>> but i am afraid this is a bit too high for me. I can say that the
>> analog output works, even at high sampling rates.
>> And I have read something about a clock source could be the problem.
>> I'm sorry I can't tell you any more.
>>
>> mfg
>> Markus
