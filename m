From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
Date: Mon, 19 Mar 2018 11:29:22 +0100
Message-ID: <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
References: <20180318153512.8343-1-krzk@kernel.org>
        <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180318153512.8343-1-krzk@kernel.org>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
> Compatible for XU4 audio is not being used.  Instead the board uses the
> same compatible as XU3.  The devices are now just compatible so they
> should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
> deprecated so in this future could be removed to limit useless
> properties.

It doesn't feel right to obsolete the "hardkernel,odroid-xu4-audio"
compatible, there is significant difference between XU3 and XU4 - there
is no audio CODEC on XU4, this board only supports audio over HDMI interface.
XU4 could be compatible with XU3, but not the other way around.
It just happens we have other DT properties that help to handle such HW 
design difference.

Moreover, only XU4 is still in production and should be in few more years [1], 
others are obsoleted now.

So I think we should keep at least these 2 compatible strings:

- "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
- "hardkernel,odroid-xu4-audio" - for boards without audio CODEC, 
   supporting only HDMI interface.

--
Thanks,
Sylwester

[1] https://com.odroid.com/sigong/blog/blog_list.php
