From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 08/14] dt-bindings: sound: Add sun8i analog
 codec documentation
Date: Wed, 5 Oct 2016 10:59:47 +0800
Message-ID: <CAGb2v67gT9j6-NYj04+et2PNHRGFUzhgCnVgX+eoPGybArL60A@mail.gmail.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004162430.GQ5228@lukather>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBO6Z2G7QKGQEPB5QNMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161004162430.GQ5228@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 5, 2016 at 12:24 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> On Tue, Oct 04, 2016 at 11:46:21AM +0200, Myl=C3=A8ne Josserand wrote:
>> Add the documentation for dt-binding of the analog audiocodec
>> driver for SUN8I SoC.
>>
>> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>
>> ---
>>  .../devicetree/bindings/sound/sun8i-codec-analog.txt | 20 +++++++++++++=
+++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-=
analog.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.=
txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>> new file mode 100644
>> index 0000000..a03ec20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>> @@ -0,0 +1,20 @@
>> +* Allwinner A23/A33 Analog Codec
>> +
>> +This codec must be handled as a PRCM subnode.
>
> Like Mark was saying, you should probably reference the sun6i-prcm.txt
> binding here
>
>> +Required properties:
>> +- compatible: must be either "allwinner,sun8i-codec-analog"
>
> Our compatible prefix is <family>-<soc>, and using the older SoC that
> introduced that block.
>
> In this case, that would be sun6i-a31, I think?

sun6i-a31s actually, but a31s has extra line out controls,
so the right one would be sun8i-a23. Both are listed in my
original driver.

ChenYu

>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
