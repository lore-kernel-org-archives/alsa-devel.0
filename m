From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as deprecated
Date: Mon, 19 Mar 2018 11:56:00 +0100
Message-ID: <CAJKOXPcBesWpBoq07XbE1j3F1_N5dAWMTRkv8SN=tSMEm1q0iQ@mail.gmail.com>
References: <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
 <20180318153512.8343-1-krzk@kernel.org> <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2018 at 11:29 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
>> Compatible for XU4 audio is not being used.  Instead the board uses the
>> same compatible as XU3.  The devices are now just compatible so they
>> should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
>> deprecated so in this future could be removed to limit useless
>> properties.
>
> It doesn't feel right to obsolete the "hardkernel,odroid-xu4-audio"
> compatible, there is significant difference between XU3 and XU4 - there
> is no audio CODEC on XU4, this board only supports audio over HDMI interface.
> XU4 could be compatible with XU3, but not the other way around.
> It just happens we have other DT properties that help to handle such HW
> design difference.

The compatible does not describe physical differences. It does not
mean that devices are the same. In this case they are just coming from
the same family and they operate the same, from the bindings
perspective.

The XU4 binding is not being used. Adding a compatible which is not
used in the moment of adding is a proof that this compatible is not
needed. It is just a duplicate. There is no point of adding
duplicates.

>
> Moreover, only XU4 is still in production and should be in few more years [1],
> others are obsoleted now.

It is not a problem. Whether device is manufactured or not, does not
reflect what bindings we are using. Deprecated XU4 compatible does not
mean that XU4 itself is deprecated. Just this compatible should not be
used for new DTS.

>
> So I think we should keep at least these 2 compatible strings:
>
> - "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
> - "hardkernel,odroid-xu4-audio" - for boards without audio CODEC,
>    supporting only HDMI interface.

Yeah, and then we inflate this list into X, X2, U3, HC1 and all others
which are the same. And then we should add XU3-lite (it is different
device). This goes to some nonsense. Compatible is not for each device
but for family even though there are differences between specific
devices.

Best regards,
Krzysztof
